# ------------------------------------------------------------------------------
#              COSTeam Account Resource Creation and Access Policies
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Create and Provision S3 bucket where the Terraform state will be stored.
# 
# Security: Block ANY public access to the bucket or the objects it contains
#           even if misconfigured to allow public access.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "tf_bucket" {
  
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

resource "aws_s3_bucket_public_access_block" "tf_bucket" {
  bucket = aws_s3_bucket.tf_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ------------------------------------------------------------------------------
# Create DynamoDB Table used for the Terraform state locking.
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "tf_dynamodb" {
   attribute {
    name = "LockID"
    type = "S"
  }
  hash_key       = "LockID"
  name           = var.dynamodb_table_name
  read_capacity  = var.dynamodb_table_read_capacity
  write_capacity = var.dynamodb_table_write_capacity
}

# ------------------------------------------------------------------------------
#                   Associated IAM Roles and Policies
# ------------------------------------------------------------------------------



