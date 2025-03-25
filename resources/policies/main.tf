
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