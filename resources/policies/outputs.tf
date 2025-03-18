output "ec2_s3_policy_arn" {
  description = "ARN of the custom S3 policy for EC2 user"
  value       = aws_iam_policy.ec2_s3_policy.arn
}

output "aws_region" {
  description = "The current AWS region"
  value       = data.aws_region.current.name
}