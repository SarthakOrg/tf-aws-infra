resource "aws_lb" "webapp_lb" {
  name               = "webapp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "webapp-lb"
  }
}

resource "aws_lb_target_group" "webapp_tg" {
  name        = "webapp-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/healthz"
    interval            = 120
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
    matcher             = "200"
  }

  tags = {
    Name = "webapp-tg"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.webapp_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.ssl_certificate_arn
  depends_on        = [aws_lb.webapp_lb]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp_tg.arn
  }
}