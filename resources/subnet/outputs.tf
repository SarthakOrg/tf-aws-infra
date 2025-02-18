output "public_subnet_ids" {
  # The IDs of the public subnets
  description = "The IDs of the public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  # The IDs of the private subnets
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}
