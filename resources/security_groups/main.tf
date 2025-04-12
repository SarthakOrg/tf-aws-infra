resource "aws_security_group" "app_sg" {
  name        = var.sg_desc
  description = "Security group for EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    description     = "Allow application traffic"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_desc
  }
}

resource "aws_security_group" "db_sg" {
  name        = "database-security-group"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MySQL traffic from application security group"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-security-group"
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "load-balancer-security-group"
  description = "Security group for Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "load-balancer-security-group"
  }
}
