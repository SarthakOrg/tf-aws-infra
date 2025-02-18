output "internet_gateway_id" {
  # The ID of the Internet Gateway
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}
