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

data "aws_route53_zone" "selected" {
  name = var.domain_name
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
  source   = "./resources/security_groups"
  sg_desc  = var.sg_desc
  vpc_id   = module.vpc.vpc_id
  app_port = var.app_port
}

# module "ec2" {
#   # Source the EC2 module and pass necessary variables
#   source             = "./resources/ec2"
#   ami_id             = var.ami_id
#   instance_type      = var.instance_type
#   instance_name      = var.instance_name
#   key_name           = var.key_name
#   security_group_ids = [module.security_groups.app_sg_id]
#   subnet_id          = module.subnet.public_subnet_ids[0]
#   rds_endpoint       = module.rds_instance.rds_endpoint
#   rds_username       = module.rds_instance.rds_username
#   rds_password       = module.rds_instance.rds_password
#   rds_name           = module.rds_instance.rds_name
#   bucket_name        = module.s3_bucket.bucket_name
# }

module "autoscaler" {
  source                        = "./resources/autoscaler"
  ami_id                        = var.ami_id
  instance_type                 = var.instance_type
  key_name                      = var.key_name
  security_group_ids            = [module.security_groups.app_sg_id]
  target_group_arns             = [module.load_balancer.target_group_arn]
  aws_iam_instance_profile_name = var.instance_profile_name
  public_subnet_ids             = module.subnet.public_subnet_ids
  rds_endpoint                  = module.rds_instance.rds_endpoint
  rds_username                  = module.rds_instance.rds_username
  rds_password                  = module.rds_instance.rds_password
  rds_name                      = module.rds_instance.rds_name
  bucket_name                   = module.s3_bucket.bucket_name
  aws_region                    = var.aws_region
  cpu_threshold_high            = var.cpu_threshold_high # CPU threshold for scaling up
  cpu_threshold_low             = var.cpu_threshold_low  # CPU threshold for scaling down
}

module "s3_bucket" {
  source      = "./resources/s3_bucket"
  bucket_name = format("%s-%s", var.bucket_name, uuid())
}

module "policies" {
  source      = "./resources/policies"
  bucket_name = module.s3_bucket.bucket_name

  depends_on = [module.s3_bucket, module.rds_instance]
}

# Call the IAM Roles Configuration module
module "iam" {
  source            = "./resources/iam"
  ec2_s3_policy_arn = module.policies.ec2_s3_policy_arn
  depends_on        = [module.policies]
}

module "rds_instance" {
  source             = "./resources/rds_instance"
  rds_instance_class = var.rds_instance_class
  db_family          = var.db_family
  private_subnet_ids = module.subnet.private_subnet_ids
  db_sg_id           = module.security_groups.db_sg_id
  db_name            = var.db_name
  db_user            = var.db_user
  db_password        = var.db_password
}

module "load_balancer" {
  source                 = "./resources/load_balancer"
  lb_security_group_id   = module.security_groups.lb_sg_id
  public_subnet_ids      = module.subnet.public_subnet_ids
  vpc_id                 = module.vpc.vpc_id
  autoscaling_group_name = module.autoscaler.autoscaling_group_name
  app_port               = var.app_port

  depends_on = [module.vpc, module.subnet, module.security_groups]
}

module "route53" {
  source       = "./resources/route53"
  zone_id      = data.aws_route53_zone.selected.zone_id
  zone_name    = data.aws_route53_zone.selected.name
  elb_dns_name = module.load_balancer.elb_dns_name
  elb_zone_id  = module.load_balancer.elb_zone_id

  depends_on = [module.load_balancer]
}
