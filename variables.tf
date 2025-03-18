# Define the AWS region to create resources in
variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

# Define the AWS profile to use
variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
}

# Define the CIDR block for the VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# Define the name of the VPC
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "cloud-vpc"
}

# Define the name of the Internet Gateway
variable "internet_gateway_name" {
  description = "The name of the Internet Gateway"
  type        = string
}

# Define a list of CIDR blocks for the public subnets
variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

# Define a list of CIDR blocks for the private subnets
variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

# Define a list of availability zones to use for the subnets
variable "availability_zones" {
  description = "A list of availability zones to use for the subnets"
  type        = list(string)
}

# Define the AMI ID for the EC2 instance
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

# Define the instance type for the EC2 instance
variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

# Define the name of the EC2 instance
variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

# Define the description for the security group
variable "sg_desc" {
  description = "Description for the security group"
  type        = string
}

# Define the application port for the security group
variable "app_port" {
  description = "Application port for the security group"
  type        = number
}

# Define the SSH key name for the EC2 instance
variable "key_name" {
  description = "SSH key name for the EC2 instance"
  type        = string
}

# Define the name of the S3 bucket
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = ""
}

# Define the instance class for the RDS instance
variable "rds_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

# Define the database family for the RDS instance
variable "db_family" {
  description = "The database family for the RDS instance"
  type        = string
}

# Define the ARN of the AWS Secrets Manager secret for RDS credentials
variable "rds_credentials_secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret for RDS credentials"
  type        = string
}

variable "instance_profile_name" {
  description = "The name of the IAM instance profile to attach to the EC2 instance"
  type        = string
  default     = "ec2_profile"
}
