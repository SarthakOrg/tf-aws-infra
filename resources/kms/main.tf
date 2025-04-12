data "aws_caller_identity" "current" {}

resource "aws_kms_key" "ec2_key" {
  description             = "KMS key for EC2 encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 10
  rotation_period_in_days = 90
  tags = {
    Name = "ec2-key"
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-2"
    Statement = [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
        },
        "Action" : [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow attachment of persistent resources",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
        },
        "Action" : [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        "Resource" : "*",
        "Condition" : {
          "Bool" : {
            "kms:GrantIsForAWSResource" : "true"
          }
        }
      }
    ]
  })
}

resource "aws_kms_key" "rds_key" {
  description             = "KMS key for RDS encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 10
  rotation_period_in_days = 90
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Allow administration of the key"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.aws_profile}",
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
          ]
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow RDS to use the key"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid    = "Allow Terraform user to use the key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.aws_profile}"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:PutKeyPolicy"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "rds-key"
  }
}

resource "aws_kms_key" "s3_key" {
  description             = "KMS key for S3 bucket encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 10
  rotation_period_in_days = 90
  tags = {
    Name = "s3-key"
  }
}

resource "aws_kms_key" "secrets_manager_key" {
  description             = "KMS key for Secrets Manager"
  enable_key_rotation     = true
  deletion_window_in_days = 10
  rotation_period_in_days = 90
  tags = {
    Name = "secrets-manager-key"
  }
}

resource "aws_kms_alias" "ec2_key_alias" {
  name          = "alias/ec2-key"
  target_key_id = aws_kms_key.ec2_key.id
}

resource "aws_kms_alias" "rds_key_alias" {
  name          = "alias/rds-key"
  target_key_id = aws_kms_key.rds_key.id
}

resource "aws_kms_alias" "s3_key_alias" {
  name          = "alias/s3-key"
  target_key_id = aws_kms_key.s3_key.id
}

resource "aws_kms_alias" "secrets_manager_key_alias" {
  name          = "alias/secrets-manager-key"
  target_key_id = aws_kms_key.secrets_manager_key.id
}
