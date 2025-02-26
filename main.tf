terraform {
  # Specify the required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0, < 6.0"
    }
  }
}

provider "aws" {
  # Configure the AWS provider with region and profile
  region  = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  # Source the VPC module and pass necessary variables
  source   = "./resources/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

module "subnet" {
  # Source the subnet module and pass necessary variables
  source               = "./resources/subnet"
  vpc_id               = module.vpc.vpc_id
  vpc_name             = var.vpc_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "internet_gateway" {
  # Source the internet gateway module and pass necessary variables
  source                = "./resources/internet_gateway"
  vpc_id                = module.vpc.vpc_id
  vpc_name              = var.vpc_name
  internet_gateway_name = var.internet_gateway_name
}

module "route_table" {
  # Source the route table module and pass necessary variables
  source              = "./resources/route_table"
  vpc_id              = module.vpc.vpc_id
  vpc_name            = var.vpc_name
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  public_subnet_ids   = module.subnet.public_subnet_ids
  private_subnet_ids  = module.subnet.private_subnet_ids
}

module "security_groups" {
  # Source the security group module and pass necessary variables
  source  = "./resources/security_groups"
  sg_desc = var.sg_desc
  vpc_id  = module.vpc.vpc_id
}

module "ec2" {
  # Source the EC2 module and pass necessary variables
  source             = "./resources/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  instance_name      = var.instance_name
  key_name           = var.key_name
  security_group_ids = [module.security_groups.app_sg_id]
  subnet_id          = module.subnet.public_subnet_ids[0]
}
