resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2_s3_role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Effect" : "Allow"
      }
    ]
  })

  tags = {
    name = "ec2_s3_role"
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each = {
    customEc2UserS3Policy            = var.ec2_s3_policy_arn
    customEc2SUserecretManagerPolicy = var.ec2_secretmanager_access_policy_arn
  }

  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_s3_role.name
}