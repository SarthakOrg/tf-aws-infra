resource "aws_route_table" "public" {
  # Create a public route table for the VPC
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route" "public_route" {
  # Create a route in the public route table
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route_table_association" "public" {
  # Associate public subnets with the public route table
  for_each       = { for idx, id in var.public_subnet_ids : idx => id }
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  # Create a private route table for the VPC
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  # Associate private subnets with the private route table
  for_each       = { for idx, id in var.private_subnet_ids : idx => id }
  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
