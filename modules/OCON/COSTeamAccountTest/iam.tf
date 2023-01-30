# ------------------------------------------------------------------------------
#                               IAM Policies
# ------------------------------------------------------------------------------

// Define Assessments_AssumeRole IAM Policy Permissions
data "aws_iam_policy_document" "assume_role_policy_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [
 	"arn:aws:iam::${local.costeamusers_account_id}:root",
      ] 
    }
  }
}

# -------------------------  AssumeAnyRoleAnywhere  ----------------------------

// Define AssumeAnyRoleAnywhere IAM Policy Permissions
data "aws_iam_policy_document" "assume_any_role_anywhere_policy_doc" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    resources = [
      "arn:aws:iam::*:role/*"
    ]
  }
}

// Create IAM Policy: AssumeAnyRoleAnywhere
resource "aws_iam_policy" "assume_any_role_anywhere_policy" {
  description = var.assume_any_role_anywhere_policy_description
  name        = var.assume_any_role_anywhere_policy_name
  policy      = data.aws_iam_policy_document.assume_any_role_anywhere_policy_doc.json
}


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ---------------------------AccessTerraformResources---------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: AccessTerraformResources 
resource "aws_iam_role" "terraformresources_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc.json
  description        = var.terraformresources_role_description
  name               = var.terraformresources_role_name
}

// Define AccessTerraformResources IAM Role and Policy Permissions
data "aws_iam_policy_document" "terraform_resources_policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.tf_bucket.arn, 
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.tf_bucket.arn}/*", 
    ]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      aws_dynamodb_table.tf_dynamodb.arn, 
    ]
  }
}

// Create IAM Policy: AccessTerraformResources
resource "aws_iam_policy" "terraformresources_access_policy" {
  description        = var.terraformresources_role_description
  name               = var.terraformresources_role_name
  policy      = data.aws_iam_policy_document.terraform_resources_policy_doc.json
}

// Attach the IAM policy to the IAM Role: AccessTerraformResources
resource "aws_iam_role_policy_attachment" "terraformbackend_policy_attachment" {
  policy_arn = aws_iam_policy.terraformresources_access_policy.arn
  role       = aws_iam_role.terraformresources_role.name
}
