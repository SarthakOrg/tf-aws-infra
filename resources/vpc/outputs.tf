output "vpc_id" {
  # The ID of the VPC
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
