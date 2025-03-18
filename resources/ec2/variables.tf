variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "The security group IDs to attach to the instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name to use for the instance"
  type        = string
}

variable "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  type        = string
}

variable "rds_username" {
  description = "The username for the RDS instance"
  type        = string
}

variable "rds_password" {
  description = "The password for the RDS instance"
  type        = string
}

variable "rds_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "aws_iam_instance_profile_name" {
  description = "The name of the IAM instance profile to attach to the EC2 instance"
  type        = string
  default     = "ec2_profile"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to use for the application"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the resources are created"
  type        = string
  default     = "us-east-1"
}