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

variable "private_subnet_ids" {
  description = "A list of IDs for the private subnets"
  type        = list(string)
}

variable "db_sg_id" {
  description = "The ID of the database security group"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_user" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}
