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

output "app_sg_id" {
  description = "The ID of the application security group"
  value       = module.security_groups.app_sg_id
}

output "db_sg_id" {
  description = "The ID of the database security group"
  value       = module.security_groups.db_sg_id
}

output "lb_sg_id" {
  description = "The ID of the load balancer security group"
  value       = module.security_groups.lb_sg_id
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds_instance.rds_endpoint
}

output "rds_username" {
  description = "The username for the RDS instance"
  value       = module.rds_instance.rds_username
}

output "rds_name" {
  description = "The name of the RDS database"
  value       = module.rds_instance.rds_name
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3_bucket.bucket_name
}

output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = module.autoscaler.autoscaling_group_name
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = module.autoscaler.launch_template_id
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.load_balancer.alb_dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the Application Load Balancer"
  value       = module.load_balancer.alb_zone_id
}

output "target_group_arn" {
  description = "The ARN of the target group associated with the load balancer"
  value       = module.load_balancer.target_group_arn
}

output "a_record_name" {
  description = "The name of the A record"
  value       = module.route53.a_record_name
}
