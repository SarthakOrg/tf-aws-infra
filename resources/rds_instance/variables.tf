variable "rds_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "ingress_cidrs" {
  description = "List of CIDR blocks for ingress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_family" {
  description = "The database family for the RDS instance"
  type        = string
}

variable "rds_credentials_secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret for RDS credentials"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of IDs for the private subnets"
  type        = list(string)
}

variable "db_sg_id" {
  description = "The ID of the database security group"
  type        = string
}
