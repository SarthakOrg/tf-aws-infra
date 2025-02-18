output "vpc_id" {
  # The ID of the VPC
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  # The IDs of the public subnets
  description = "The IDs of the public subnets"
  value       = module.subnet.public_subnet_ids
}

output "private_subnet_ids" {
  # The IDs of the private subnets
  description = "The IDs of the private subnets"
  value       = module.subnet.private_subnet_ids
}

output "internet_gateway_id" {
  # The ID of the Internet Gateway
  description = "The ID of the Internet Gateway"
  value       = module.internet_gateway.internet_gateway_id
}

output "public_route_table_id" {
  # The ID of the public route table
  description = "The ID of the public route table"
  value       = module.route_table.public_route_table_id
}

output "private_route_table_id" {
  # The ID of the private route table
  description = "The ID of the private route table"
  value       = module.route_table.private_route_table_id
}

output "aws_profile" {
  # The AWS profile being used
  description = "The AWS profile being used"
  value       = var.aws_profile
}
