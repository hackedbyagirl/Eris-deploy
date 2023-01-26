# ------------------------------------------------------------------------------
#                               IAM Policies and Roles
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ---------------------------AccessTerraformBackend-----------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------


data "aws_iam_policy_document" "terraformbackend_access_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.state_bucket.arn, # vARIABLE ?
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.var.state_bucket.arn}/*", # vARIABLE ?
    ]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      aws_dynamodb_table.dynamodb_table_name.arn, # vARIABLE ?
    ]
  }
}

resource "aws_iam_policy" "terraformbackend_access_policy" {
  description = var.terraformbackend_role_description
  name        = var.terraformbackend_role_name
  policy      = data.aws_iam_policy_document.terraformbackend_access_doc.json
}

resource "aws_iam_role" "terraformbackend_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.terraformbackend_role_description
  name               = var.terraformbackend_role_name
}

// Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "terraformbackend_policy_attachment" {
  policy_arn = aws_iam_policy.terraformbackend_access_policy.arn
  role       = aws_iam_role.terraformbackend_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# -------------------------------ProvisionBackend-------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionbackend_doc" {
  # Permissions necessary to manipulate the state bucket
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.state_bucket_name}",
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

resource "aws_iam_policy" "provisionbackend_policy" {
  description = var.provisionbackend_policy_description
  name        = var.provisionbackend_policy_name
  policy      = data.aws_iam_policy_document.provisionbackend_doc.json
}

# Attach Policy Document
resource "aws_iam_role_policy_attachment" "provisionbackend_policy_attachment" {
  policy_arn = aws_iam_policy.provisionbackend_policy.arn
  role       = module.provisionaccount.provisionaccount_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# -----------------------------ReadTerraformState-------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "read_terraform_state_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.var.state_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.var.state_bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "read_terraform_state_policy" {
  description = var.read_terraform_state_role_description
  name        = var.read_terraform_state_role_name
  policy      = data.aws_iam_policy_document.read_terraform_state_doc.json
}



# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# -------------------------PhishingCampaignAssessment---------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "pca_terraform_access_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.var.state_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    # Any workspace of any project in var.pca_terraform_projects
    resources = [for tf_project in var.pca_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.var.state_bucket.arn, tf_project)]
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

resource "aws_iam_policy" "pca_terraform_access_policy" {
  description = var.pca_terraform_role_description
  name        = var.pca_terraform_role_name
  policy      = data.aws_iam_policy_document.pca_terraform_access_doc.json
}

resource "aws_iam_role" "pca_terraform_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.pca_terraform_role_description
  name               = var.pca_terraform_role_name
}

// Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "pca_terraform_policy_attachment" {
  policy_arn = aws_iam_policy.pca_terraform_access_policy.arn
  role       = aws_iam_role.pca_terraform_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ----------------------AccessDomainManagerTerraformBackend---------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "terraform_domainmanger_access_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.state_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    # Any workspace of any project in var.domainmanager_terraform_projects
    resources = [for tf_project in var.domainmanager_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.var.state_bucket.arn, tf_project)]
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

resource "aws_iam_policy" "terraform_domainmanger_access_policy" {
  description = var.terraform_domainmanger_role_description
  name        = var.terraform_domainmanger_role_name
  policy      = data.aws_iam_policy_document.terraform_domainmanger_access_doc.json
}

resource "aws_iam_role" "terraform_domainmanger_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.terraform_domainmanger_role_description
  name               = var.terraform_domainmanger_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "terraform_domainmanger_policy_attachment" {
  policy_arn = aws_iam_policy.terraform_domainmanger_access_policy.arn
  role       = aws_iam_role.terraform_domainmanger_role.name
}
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ---------------------------------AssumeRole-----------------------------------
# ------------------------------------------------------------------------------
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

















