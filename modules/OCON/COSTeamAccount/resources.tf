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
  depends_on = [
    aws_iam_role_policy_attachment.provisionbackend_policy_attachment,
  ]

  bucket = var.s3_bucket_name
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
  depends_on = [
    aws_iam_role_policy_attachment.provisionbackend_policy_attachment,
  ]

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


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ---------------------------WriteAssessmentFindings---------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: WriteAssessmentFindings 
resource "aws_iam_role" "write_assessment_findings_role" {
  assume_role_policy = data.aws_iam_policy_document.assessment_account_assume_role_doc.json
  description        = var.write_assessment_findings_role_description
  name               = var.write_assessment_findings_role_name
}

// Define AccessTerraformResources IAM Role and Policy Permissions
data "aws_iam_policy_document" "write_assessment_findings_policy_doc" {
  statement {
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${var.assessment_findings_bucket_name}/${var.assessment_findings_bucket_object_key_pattern}",
    ]
  }
}

// Create IAM Policy: AccessTerraformResources
resource "aws_iam_policy" "write_assessment_findings_policy" {
  description = var.write_assessment_findings_role_description
  name        = var.write_assessment_findings_role_name
  policy      = data.aws_iam_policy_document.write_assessment_findings_policy_doc.json
}

// Attach the IAM policy to the IAM Role: AccessTerraformResources
resource "aws_iam_role_policy_attachment" "write_assessment_findings" {
  policy_arn = aws_iam_policy.write_assessment_findings_policy.arn
  role       = aws_iam_role.write_assessment_findings_role.name
}

