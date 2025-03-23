variable "ec2_s3_policy_arn" {
  description = "ARN of the custom S3 policy for EC2 user"
}

variable "iam_policy_arn_CloudWatchLogPolicy" {
  description = "ARN of the custom CloudWatch Log policy"
}

variable "iam_policy_arn_CloudWatchMetricsPolicy" {
  description = "ARN of the custom CloudWatch Metrics policy"
}