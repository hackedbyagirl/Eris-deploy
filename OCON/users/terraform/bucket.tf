# ------------------------------------------------------------------------------
# Provision the S3 bucket where the Terraform state will be stored.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "tf_bucket" {
  depends_on = [
    aws_iam_role_policy_attachment.provisionbackend_policy_attachment,
  ]

  bucket = var.s3_bucket
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = true
  }
}

# This blocks ANY public access to the bucket or the objects it
# contains, even if misconfigured to allow public access.
resource "aws_s3_bucket_public_access_block" "tf_bucket" {
  bucket = aws_s3_bucket.tf_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
