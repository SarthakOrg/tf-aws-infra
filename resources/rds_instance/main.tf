resource "random_string" "random" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "rds_password_secret" {
  name        = uuid()
  description = "Secret to store RDS instance password"
  kms_key_id  = var.secrets_manager_kms_key_arn
}

resource "aws_secretsmanager_secret_version" "rds_password_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_password_secret.id
  secret_string = jsonencode({
    password = random_string.random.result
  })
}

data "aws_secretsmanager_secret_version" "rds-password" {
  secret_id  = aws_secretsmanager_secret.rds_password_secret.id
  depends_on = [aws_secretsmanager_secret_version.rds_password_secret_version]
}

resource "aws_db_instance" "rds_instance" {
  identifier                   = "csye6225"
  engine                       = "mysql"
  instance_class               = var.rds_instance_class
  allocated_storage            = 20
  db_name                      = var.db_name
  username                     = var.db_user
  password                     = jsondecode(data.aws_secretsmanager_secret_version.rds-password.secret_string)["password"]
  db_subnet_group_name         = aws_db_subnet_group.rds-subnet-group.name
  vpc_security_group_ids       = [var.db_sg_id]
  parameter_group_name         = aws_db_parameter_group.mysql.name
  multi_az                     = false
  publicly_accessible          = false
  skip_final_snapshot          = true
  performance_insights_enabled = false
  storage_encrypted            = true
  kms_key_id                   = var.rds_kms_key_arn

  tags = {
    Name = "mysql-rds-instance"
  }

  depends_on = []

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


