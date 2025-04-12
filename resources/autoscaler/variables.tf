variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "The key pair name for the EC2 instances"
  type        = string
}

variable "security_group_ids" {
  description = "The security group IDs for the EC2 instances"
  type        = list(string)
}

variable "aws_iam_instance_profile_name" {
  description = "The IAM instance profile name for the EC2 instances"
  type        = string
}

variable "public_subnet_ids" {
  description = "The public subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  type        = string
}

variable "rds_username" {
  description = "The username for the RDS instance"
  type        = string
}

variable "rds_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "cpu_threshold_high" {
  description = "The CPU utilization threshold for scaling up"
  type        = number
}

variable "cpu_threshold_low" {
  description = "The CPU utilization threshold for scaling down"
  type        = number
}

variable "target_group_arns" {
  description = "The ARN of the target group for the load balancer"
  type        = list(string)
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling group"
  type        = number
}

variable "desired_capacity" {
  description = "The desired capacity of the Auto Scaling group"
  type        = number
}

variable "rds_password_secret_name" {
  description = "The name of the RDS password secret in Secrets Manager"
  type        = string
}

variable "secrets_manager_kms_key_arn" {
  description = "The ARN of the KMS key for Secrets Manager"
  type        = string
}

variable "ec2_kms_key_arn" {
  description = "The ARN of the KMS key for EC2 encryption"
  type        = string
}