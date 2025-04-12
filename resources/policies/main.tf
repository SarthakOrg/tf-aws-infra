# Fetch current AWS region
data "aws_region" "current" {}

# Fetch current AWS account ID
data "aws_caller_identity" "current" {}

# Custom S3 Policy
resource "aws_iam_policy" "ec2_s3_policy" {
  name = "ec2_s3_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_secrets_policy" {
  name        = "EC2SecretsManagerAccessPolicy"
  description = "Policy to allow EC2 instances to fetch secrets from Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "${var.rds_password_secret_arn}"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:*"
        ]
        Resource = [
          "${var.secrets_manager_kms_key_arn}",
          "${var.s3_kms_key_arn}"
        ]
      }
    ]
  })
}