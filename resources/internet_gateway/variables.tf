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

variable "internet_gateway_name" {
  # The name of the Internet Gateway
  description = "The name of the Internet Gateway"
  type        = string
}
