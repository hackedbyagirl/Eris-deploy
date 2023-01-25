# ------------------------------------------------------------------------------
# Creates IAM Policies that will be associated with created IAM Roles
#  
#   IAM Policies:
#   - Administer Single Sign-On (SSO) resources required in this account.
#   - Creates Routing Table for VPC
#   - Associates Route Table to Public Subnet
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#             IAM policy: Single Sign-On (SSO) Resources Deligation
# ------------------------------------------------------------------------------
resource "aws_iam_policy" "sso_policy" {
  description = var.sso_role_description
  name        = var.sso_role_name
  policy      = data.aws_iam_policy_document.sso_policy_doc.json
}


# ------------------------------------------------------------------------------
# Defines IAM Policies 
#
#   IAM Policy Documents:
#   - Allow Single Sign-On (SSO) (sso_policy)
#   - Creates Routing Table for VPC
#   - Associates Route Table to Public Subnet
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# IAM Policy - SSO-Policy: Permission to administer Single Sign-On (SSO)
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "sso_policy" {
  description = var.sso_role_description
  name        = var.sso_role_name
  policy      = data.aws_iam_policy_document.sso_policy_doc.json
}

