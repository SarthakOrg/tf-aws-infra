output "ec2_kms_key_arn" {
  description = "ARN of the KMS key for EC2"
  value       = aws_kms_key.ec2_key.arn
}

output "rds_kms_key_arn" {
  description = "ARN of the KMS key for RDS"
  value       = aws_kms_key.rds_key.arn
}

output "s3_kms_key_arn" {
  description = "ARN of the KMS key for S3"
  value       = aws_kms_key.s3_key.arn
}

output "secrets_manager_kms_key_arn" {
  description = "ARN of the KMS key for Secrets Manager"
  value       = aws_kms_key.secrets_manager_key.arn
}
