resource "aws_internet_gateway" "main" {
  # Create an Internet Gateway for the VPC
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-${var.internet_gateway_name}"
  }
}
