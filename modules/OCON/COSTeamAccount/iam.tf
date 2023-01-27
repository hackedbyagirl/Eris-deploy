# ------------------------------------------------------------------------------
#                            General IAM Policies and Roles
# ------------------------------------------------------------------------------

// Define Assessments_AssumeRole IAM Policy Permissions
data "aws_iam_policy_document" "assessment_account_assume_role_policy_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.assessment_account_ids
    }
  }
}

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