variable "ec2_s3_policy_arn" {
  description = "ARN of the custom S3 policy for EC2 user"
}

variable "iam_policy_arn_CloudWatchAgentServerPolicy" {
  description = "ARN of the custom CloudWatch Log policy"
  default     = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

variable "ec2_secrets_policy_arn" {
  description = "ARN of the EC2 Secrets Manager access policy"
}