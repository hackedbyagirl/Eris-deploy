# ------------------------------------------------------------------------------
# Defines IAM Policies 
#
#   IAM Policy Documents:
#   - Allow Single Sign-On (SSO) (sso_policy)
#   - Creates Routing Table for VPC
#   - Associates Route Table to Public Subnet
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#                 IAM Policy Document - AccessTerraformBackend
#
# Allows read-only access to the Terraform State S3 Bucket
#
# ------------------------------------------------------------------------------
data "aws_iam_policy_document" "access_terraform_backend_access_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.s3_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      aws_dynamodb_table.dynamodb_table_name.arn,
    ]
  }
}


# ------------------------------------------------------------------------------
#                 IAM Policy Document - ReadTerraformState
#
# Allows read-only access to the Terraform State S3 Bucket
#
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "read_terraform_state_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.s3_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }
}


# ------------------------------------------------------------------------------
#                 IAM Policy Document - ProvisionBackend
#
# Sufficient permissions to povision the S3 bucket and DynamoDB table resources
# For the Terraform backend in the terraform account.
#
# ------------------------------------------------------------------------------
data "aws_iam_policy_document" "provisionbackend_doc" {
  # Permissions necessary to manipulate the state bucket
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
  }

  # Permissions necessary to manipulate the state lock table
  statement {
    actions = [
      "dynamodb:*",
    ]
    resources = [
      "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.terraform.account_id}:table/${var.dynamodb_table_name}",
    ]
  }
}

# ------------------------------------------------------------------------------
#                 IAM Policy Document - PhishingCampaignAssessment
#
# Access to the Phishing Campaign Assessment S3 and DynamoDB resources
# For the Terraform backend in the terraform account.
#
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "access_pca_terraform_backend_access_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.s3_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    # Any workspace of any project in var.pca_terraform_projects
    resources = [for tf_project in var.pca_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.s3_bucket.arn, tf_project)]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      aws_dynamodb_table.dynamodb_table_name.arn,
    ]
  }
}

# ------------------------------------------------------------------------------
#                 IAM Policy Document - DomainManager
#
# Access to the Phishing Campaign Assessment S3 and DynamoDB resources
# For the Terraform backend in the terraform account.
#
# ------------------------------------------------------------------------------
data "aws_iam_policy_document" "access_domainmanager_terraform_backend_access_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.s3_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    # Any workspace of any project in var.domainmanager_terraform_projects
    resources = [for tf_project in var.domainmanager_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.s3_bucket.arn, tf_project)]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      aws_dynamodb_table.dynamodb_table_name.arn,
    ]
  }
}

# ------------------------------------------------------------------------------
#                 IAM Policy Document - AssumeRole
#
# Allows the `Users` account to assume this role
#
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.users_account_id}:root",
      ]
    }
  }
}