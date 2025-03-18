output "aws_iam_role_name" {
  description = "The name of the IAM role"
  value       = aws_iam_role.ec2_s3_role.name
}

output "aws_iam_instance_profile_name" {
  description = "The name of the IAM instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}