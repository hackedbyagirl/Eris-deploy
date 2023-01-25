# ------------------------------------------------------------------------------
# Creates IAM Policies that will be associated with created IAM Roles
#  
#   IAM Policies:

# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#             IAM policy: 
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "read_terraform_state_policy" {
  description = var.read_terraform_state_role_description
  name        = var.read_terraform_state_role_name
  policy      = data.aws_iam_policy_document.read_terraform_state_doc.json
}

# ------------------------------------------------------------------------------
#             IAM policy: 
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "provisionbackend_policy" {
  description = var.provisionbackend_policy_description
  name        = var.provisionbackend_policy_name
  policy      = data.aws_iam_policy_document.provisionbackend_doc.json
}

# ------------------------------------------------------------------------------
#             IAM policy: 
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "access_terraform_backend_access_policy" {
  description = var.access_terraform_backend_role_description
  name        = var.access_terraform_backend_role_name
  policy      = data.aws_iam_policy_document.access_terraform_backend_access_doc.json
}

# ------------------------------------------------------------------------------
#             IAM policy: 
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "access_pca_terraform_backend_access_policy" {
  description = var.access_pca_terraform_backend_role_description
  name        = var.access_pca_terraform_backend_role_name
  policy      = data.aws_iam_policy_document.access_pca_terraform_backend_access_doc.json
}

# ------------------------------------------------------------------------------
#             IAM policy: 
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "access_domainmanager_terraform_backend_access_policy" {
  description = var.access_domainmanager_terraform_backend_role_description
  name        = var.access_domainmanager_terraform_backend_role_name
  policy      = data.aws_iam_policy_document.access_domainmanager_terraform_backend_access_doc.json
}