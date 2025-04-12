variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "rds_password_secret_arn" {
  description = "The name of the RDS password secret in Secrets Manager"
  type        = string
}

variable "secrets_manager_kms_key_arn" {
  description = "The ARN of the KMS key for Secrets Manager"
  type        = string
}

variable "s3_kms_key_arn" {
  description = "The ARN of the KMS key for S3"
  type        = string
}