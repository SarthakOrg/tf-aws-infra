resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.aws_iam_instance_profile_name

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }

  user_data = <<-EOF
              #!/bin/bash
              set -e
              cd /opt/csye6225/webapp
              sudo cat .env
              echo "DB_HOST=${replace(var.rds_endpoint, ":3306", "")}" >> /opt/csye6225/webapp/.env
              echo "DB_USER=${var.rds_username}" >> /opt/csye6225/webapp/.env
              echo "DB_PASSWORD=${var.rds_password}" >> /opt/csye6225/webapp/.env
              echo "DB_NAME=${var.rds_name}" >> /opt/csye6225/webapp/.env
              echo "AWS_REGION=${var.aws_region}" >> /opt/csye6225/webapp/.env
              echo "S3_BUCKET_NAME=${var.bucket_name}" >> /opt/csye6225/webapp/.env   
              sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cloudwatch-agent-config.json -s           
              EOF  

  tags = {
    Name = var.instance_name
  }
}
