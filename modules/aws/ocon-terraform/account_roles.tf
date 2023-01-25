# ------------------------------------------------------------------------------
# Creates and defines IAM Roles that will be applied to 
# ocon-terraform-admin-account 
#
#   IAM Roles:

# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#                 IAM Role - AccessTerraformBackend
# ------------------------------------------------------------------------------

resource "aws_iam_role" "access_terraform_backend_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.access_terraform_backend_role_description
  name               = var.access_terraform_backend_role_name
}

// Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "access_terraform_backend_policy_attachment" {
  policy_arn = aws_iam_policy.access_terraform_backend_access_policy.arn
  role       = aws_iam_role.access_terraform_backend_role.name
}

# ------------------------------------------------------------------------------
# IAM Role - PhishingCampaignAssessment 
# ------------------------------------------------------------------------------

resource "aws_iam_role" "access_pca_terraform_backend_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.access_pca_terraform_backend_role_description
  name               = var.access_pca_terraform_backend_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "access_pca_terraform_backend_policy_attachment" {
  policy_arn = aws_iam_policy.access_pca_terraform_backend_access_policy.arn
  role       = aws_iam_role.access_pca_terraform_backend_role.name
}

# ------------------------------------------------------------------------------
# IAM Role - DomainManager
# ------------------------------------------------------------------------------

resource "aws_iam_role" "access_domainmanager_terraform_backend_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.access_domainmanager_terraform_backend_role_description
  name               = var.access_domainmanager_terraform_backend_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "access_domainmanager_terraform_backend_policy_attachment" {
  policy_arn = aws_iam_policy.access_domainmanager_terraform_backend_access_policy.arn
  role       = aws_iam_role.access_domainmanager_terraform_backend_role.name
}


# ------------------------------------------------------------------------------
# IAM Role - ProvisionBackend
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionbackend_policy_attachment" {
  policy_arn = aws_iam_policy.provisionbackend_policy.arn
  role       = module.provisionaccount.provisionaccount_role.name
}


