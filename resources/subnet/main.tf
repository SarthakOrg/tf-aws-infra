resource "aws_subnet" "public" {
  # Create public subnets for the VPC
  for_each                = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  vpc_id                  = var.vpc_id
  cidr_block              = each.value
  availability_zone       = element(var.availability_zones, each.key)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private" {
  # Create private subnets for the VPC
  for_each          = { for idx, cidr in var.private_subnet_cidrs : idx => cidr }
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = element(var.availability_zones, each.key)

  tags = {
    Name = "${var.vpc_name}-private-subnet-${each.key}"
  }
}
