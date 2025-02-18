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
