variable "vpc_id" {
  # The ID of the VPC
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_name" {
  # The name of the VPC
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  # A list of CIDR blocks for the public subnets
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  # A list of CIDR blocks for the private subnets
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  # A list of availability zones to use for the subnets
  description = "A list of availability zones to use for the subnets"
  type        = list(string)
}
