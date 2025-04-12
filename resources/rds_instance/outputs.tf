output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_username" {
  description = "The username for the RDS instance"
  value       = aws_db_instance.rds_instance.username
}

output "rds_name" {
  description = "The name of the RDS database"
  value       = aws_db_instance.rds_instance.db_name
}

output "rds_password_secret_name" {
  description = "The name of the RDS password secret"
  value       = aws_secretsmanager_secret.rds_password_secret.name
}

output "rds_password_secret_arn" {
  description = "The name of the RDS password secret"
  value       = aws_secretsmanager_secret.rds_password_secret.arn
}