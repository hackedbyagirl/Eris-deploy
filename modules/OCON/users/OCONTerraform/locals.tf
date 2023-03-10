# ------------------------------------------------------------------------------
# Retrieve the information for all accounts in the organization.  This
# is used, for instance, to lookup the account ID for the Users
# account.
#
# Note: Do I need to change for PoC Purpose since I dont have Org
# ------------------------------------------------------------------------------

data "aws_caller_identity" "oconterraform" {
}

data "aws_organizations_organization" "ocon" {
  provider = aws.organizationsreadonly
}

locals {
  # Find the Users account
  users_account_id = [
    for account in data.aws_organizations_organization.ocon.accounts :
    account.id
    if account.name == "Users"
  ][0]
}