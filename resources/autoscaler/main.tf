resource "aws_launch_template" "webapp_lt" {
  name = "webapp_lt"

  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_group_ids
  }

  iam_instance_profile {
    name = var.aws_iam_instance_profile_name
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              set -e
              cd /opt/csye6225/webapp
              sudo cat .env
              echo "DB_HOST=${replace(var.rds_endpoint, ":3306", "")}" >> /opt/csye6225/webapp/.env
              echo "DB_USER=${var.rds_username}" >> /opt/csye6225/webapp/.env
              echo "DB_PASSWORD=$(aws secretsmanager get-secret-value --secret-id ${var.rds_password_secret_name} --query SecretString --output text | jq -r '.password')" >> /opt/csye6225/webapp/.env
              echo "DB_NAME=${var.rds_name}" >> /opt/csye6225/webapp/.env
              echo "AWS_REGION=${var.aws_region}" >> /opt/csye6225/webapp/.env
              echo "S3_BUCKET_NAME=${var.bucket_name}" >> /opt/csye6225/webapp/.env   
              sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cloudwatch-agent-config.json -s
              sudo systemctl daemon-reload
              sudo systemctl restart webapp.service
              EOF
  )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 30
      volume_type           = "gp2"
      kms_key_id            = var.ec2_kms_key_arn
      encrypted             = true
      delete_on_termination = true
    }
  }
}

resource "aws_autoscaling_group" "webapp_asg" {
  name = "webapp-asg"
  launch_template {
    id      = aws_launch_template.webapp_lt.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns   = var.target_group_arns

  tag {
    key                 = "Name"
    value               = "webapp-instance"
    propagate_at_launch = true
  }

  default_cooldown = 60
}

resource "aws_autoscaling_policy" "scale_up" {
  name                    = "scale-up-policy"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  autoscaling_group_name  = aws_autoscaling_group.webapp_asg.name
  metric_aggregation_type = "Average"
}

resource "aws_autoscaling_policy" "scale_down" {
  name                    = "scale-down-policy"
  scaling_adjustment      = -1
  adjustment_type         = "ChangeInCapacity"
  autoscaling_group_name  = aws_autoscaling_group.webapp_asg.name
  metric_aggregation_type = "Average"
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_threshold_high

  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.webapp_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low-cpu-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_threshold_low

  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.webapp_asg.name
  }
}
