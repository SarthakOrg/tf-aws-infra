resource "aws_vpc" "main" {
  # Create a VPC with the specified CIDR block
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}
