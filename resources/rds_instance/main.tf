resource "aws_db_instance" "rds_instance" {
  identifier                   = "mysql-rds-instance"
  engine                       = "mysql"
  instance_class               = var.rds_instance_class
  allocated_storage            = 20
  db_name                      = var.db_name
  username                     = var.db_user
  password                     = var.db_password
  db_subnet_group_name         = aws_db_subnet_group.rds-subnet-group.name
  vpc_security_group_ids       = [var.db_sg_id]
  parameter_group_name         = aws_db_parameter_group.mysql.name
  multi_az                     = false
  publicly_accessible          = false
  skip_final_snapshot          = true
  performance_insights_enabled = false

  tags = {
    Name = "mysql-rds-instance"
  }

}

resource "aws_db_parameter_group" "mysql" {
  name        = "mysql-parameter-group"
  family      = var.db_family
  description = "Custom MySQL parameter group"

  tags = {
    Name = "mysql-parameter-group"
  }
}

resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}




