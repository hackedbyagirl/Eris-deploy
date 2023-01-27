# ------------------------------------------------------------------------------
#                               IAM Policies and Roles
# ------------------------------------------------------------------------------

// Define AssumeRole IAM Policy Permissions
data "aws_iam_policy_document" "assume_role_policy_doc" {
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

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ---------------------AccessDomainManagerTerraformResources--------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: AccessDomainManagerTerraformResources 
resource "aws_iam_role" "terraform_domainmanger_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc.json
  description        = var.terraform_domainmanger_role_description
  name               = var.terraform_domainmanger_role_name
}

// Define AccessDomainManagerTerraformResources IAM Role and Policy Permissions
data "aws_iam_policy_document" "terraform_domainmanger_policy_doc" {
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
    # Any workspace of any project in var.domainmanager_terraform_projects
    resources = [for tf_project in var.domainmanager_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.tf_bucket.arn, tf_project)]
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

// Create IAM Policy: AccessDomainManagerTerraformResources
resource "aws_iam_policy" "terraform_domainmanger_policy" {
  description = var.terraform_domainmanger_role_description
  name        = var.terraform_domainmanger_role_name
  policy      = data.aws_iam_policy_document.terraform_domainmanger_policy_doc.json
}

// Attach the IAM policy to the IAM Role: AccessDomainManagerTerraformResources
resource "aws_iam_role_policy_attachment" "terraform_domainmanger_policy_attachment" {
  policy_arn = aws_iam_policy.terraform_domainmanger_policy.arn
  role       = aws_iam_role.terraform_domainmanger_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# -------------------------AccessPCATerraformResources--------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: AccessPCATerraformResources 
resource "aws_iam_role" "pca_terraform_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc.json
  description        = var.pca_terraform_role_description
  name               = var.pca_terraform_role_name
}

// Define AccessPCATerraformResources IAM Role and Policy Permissions
data "aws_iam_policy_document" "pca_terraform_policy_doc" {
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
    # Any workspace of any project in var.pca_terraform_projects
    resources = [for tf_project in var.pca_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.tf_bucket.arn, tf_project)]
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

// Create IAM Policy: AccessPCATerraformResources
resource "aws_iam_policy" "pca_terraform_policy" {
  description = var.pca_terraform_role_description
  name        = var.pca_terraform_role_name
  policy      = data.aws_iam_policy_document.pca_terraform_policy_doc.json
}

// Attach the IAM policy to the IAM Role: AccessPCATerraformResources
resource "aws_iam_role_policy_attachment" "pca_terraform_policy_attachment" {
  policy_arn = aws_iam_policy.pca_terraform_policy.arn
  role       = aws_iam_role.pca_terraform_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# --------------------------ProvisionTerraformAccount---------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
// Using the predefined module, this will set up a IAM Role and attach the
// required policies and permissions

// Create IAM Role: ProvisionTerraformAccount 
module "provisionaccount" {
  source = "../provision-account"

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  users_account_id                  = local.users_account_id
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ----------------------ProvisionTerraformResourcesPolicy-----------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Define ProvisionTerraformResources Policy
data "aws_iam_policy_document" "provision_terraform_resources_policy_doc" {
  # Permissions necessary to manipulate the state bucket
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.tf_bucket_name}",
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

// Create IAM Policy: ProvisionTerraformResourcesPolicy
resource "aws_iam_policy" "provision_terraform_resources_policy" {
  description = var.provision_terraform_resources_policy_description
  name        = var.provision_terraform_resources_policy_name
  policy      = data.aws_iam_policy_document.provision_terraform_resources_policy_doc.json
}

// Attach the IAM policy to the IAM Role: ProvisionTerraformAccount
resource "aws_iam_role_policy_attachment" "provision_terraform_resources_policy_attachment" {
  policy_arn = aws_iam_policy.provision_terraform_resources_policy.arn
  role       = module.provisionaccount.provisionaccount_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# -----------------------------ReadTerraformState-------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: ReadTerraformState 
resource "aws_iam_role" "read_terraform_state_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc.json
  description        = var.read_terraform_state_role_description
  name               = var.read_terraform_state_role_name
}

// Define ReadTerraformState IAM Role and Policy Permissions
data "aws_iam_policy_document" "read_terraform_state_policy_doc" {
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
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.tf_bucket.arn}/*",
    ]
  }
}

// Create IAM Policy: ReadTerraformState
resource "aws_iam_policy" "read_terraform_state_policy" {
  description = var.read_terraform_state_role_description
  name        = var.read_terraform_state_role_name
  policy      = data.aws_iam_policy_document.read_terraform_state_policy_doc.json
}

// Attach the IAM policy to the IAM Role: ReadTerraformState
resource "aws_iam_role_policy_attachment" "read_terraform_state_policy_attachment" {
  policy_arn = aws_iam_policy.read_terraform_state_policy.arn
  role       = aws_iam_role.read_terraform_state_role.name
}