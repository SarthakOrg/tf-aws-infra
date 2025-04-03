output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.webapp_lb.dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the Application Load Balancer"
  value       = aws_lb.webapp_lb.zone_id
}

output "elb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.webapp_lb.dns_name
}

output "elb_zone_id" {
  description = "The zone ID of the Application Load Balancer"
  value       = aws_lb.webapp_lb.zone_id
}

output "target_group_arn" {
  description = "The ARN of the target group associated with the load balancer"
  value       = aws_lb_target_group.webapp_tg.arn
}
