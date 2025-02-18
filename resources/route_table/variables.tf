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

variable "internet_gateway_id" {
  # The ID of the Internet Gateway
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "public_subnet_ids" {
  # A list of IDs for the public subnets
  description = "A list of IDs for the public subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  # A list of IDs for the private subnets
  description = "A list of IDs for the private subnets"
  type        = list(string)
}
