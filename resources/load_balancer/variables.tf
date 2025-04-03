variable "lb_security_group_id" {
  description = "The security group ID for the load balancer"
  type        = string
}

variable "public_subnet_ids" {
  description = "The public subnet IDs for the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  type        = string
}

variable "app_port" {
  description = "The port on which the application is running"
  type        = number
}