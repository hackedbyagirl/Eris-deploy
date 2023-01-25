# ------------------------------------------------------------------------------
# Creates n AWS IAM role with permissions to:
#   - Provision any IAM resources in an AWS Account
#   - Trust a different AWS account so that the role can be assumed via IAM.
# ------------------------------------------------------------------------------

module "provisionaccount" {
  source = "../provision-account"

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  users_account_id                  = local.users_account_id
}

# ------------------------------------------------------------------------------
#  Attach a policy allowing this role to read organization information.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "read_organization" {
  policy_arn = "arn:aws:iam::aws:policy/AWSOrganizationsReadOnlyAccess"
  role       = module.provisionaccount.provisionaccount_role.name
}

# ------------------------------------------------------------------------------
#  Attach a policy allowing this role to administer the Service Catalog.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "admin_servicecatalog" {
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogAdminFullAccess"
  role       = module.provisionaccount.provisionaccount_role.name
}