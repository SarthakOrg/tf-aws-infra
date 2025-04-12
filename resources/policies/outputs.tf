output "ec2_s3_policy_arn" {
  description = "ARN of the custom S3 policy for EC2 user"
  value       = aws_iam_policy.ec2_s3_policy.arn
}

output "ec2_secrets_policy_arn" {
  description = "ARN of the EC2 Secrets Manager access policy"
  value       = aws_iam_policy.ec2_secrets_policy.arn
}

output "aws_region" {
  description = "The current AWS region"
  value       = data.aws_region.current.name
}

output "aws_account_id" {
  description = "The current AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}