output "ec2_s3_policy_arn" {
  description = "ARN of the custom S3 policy for EC2 user"
  value       = aws_iam_policy.ec2_s3_policy.arn
}

output "aws_region" {
  description = "The current AWS region"
  value       = data.aws_region.current.name
}

output "iam_policy_arn_CloudWatchLogPolicy" {
  description = "ARN of the custom CloudWatch Log policy"
  value       = aws_iam_policy.cloudwatch_metrics_policy.arn
}

output "iam_policy_arn_CloudWatchMetricsPolicy" {
  description = "ARN of the custom CloudWatch Metrics policy"
  value       = aws_iam_policy.cloudwatch_metrics_policy.arn
}