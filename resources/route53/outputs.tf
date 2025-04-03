output "a_record_name" {
  description = "The name of the A record"
  value       = aws_route53_record.a_record.name
}
