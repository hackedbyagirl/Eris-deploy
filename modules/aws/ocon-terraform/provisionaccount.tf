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
