# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient permissions to provision
# all AWS resources in the new account.
# ------------------------------------------------------------------------------

// Define ReadTerraformState IAM Role and Policy Permissions
data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.users_account_id}:root",
      ]
    }
  }
}

// Create IAM Role to Provision Accounts with Attached Assume Role Policy
resource "aws_iam_role" "provisionaccount_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.provisionaccount_role_description
  name               = var.provisionaccount_role_name
}

// Attach IAM Policy to the Provision Accounts IAM Role
resource "aws_iam_role_policy_attachment" "iamfullaccess_policy_attachment" {
  policy_arn = var.iampolicy_attachment
  role       = aws_iam_role.provisionaccount_role.name
}

// Attach IAM Policy to the Provision Accounts IAM Role
resource "aws_iam_role_policy_attachment" "servicequotasfullaccess_policy_attachment" {
  policy_arn = var.servicequotas_policy_attachment
  role       = aws_iam_role.provisionaccount_role.name
}
