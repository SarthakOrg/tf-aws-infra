output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_username" {
  description = "The username for the RDS instance"
  value       = aws_db_instance.rds_instance.username
}

output "rds_password" {
  description = "The password for the RDS instance"
  value       = aws_db_instance.rds_instance.password
}

output "rds_name" {
  description = "The name of the RDS database"
  value       = aws_db_instance.rds_instance.db_name
}