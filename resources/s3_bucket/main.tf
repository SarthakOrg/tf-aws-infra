resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = false
  }

  force_destroy = true

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.s3_kms_key_arn
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "my_bucket_lifecycle" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "transition-to-standard-ia"
    status = "Enabled"
    transition {
      days          = var.transition_days
      storage_class = "STANDARD_IA"
    }
  }
}

variable "s3_kms_key_arn" {
  description = "The ARN of the KMS key for S3"
  type        = string
}
