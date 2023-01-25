# ------------------------------------------------------------------------------
# Retrieve the information for all accounts in the organization.  This
# is used, for instance, to lookup the account IDs for all assessment
# accounts.
# ------------------------------------------------------------------------------
data "aws_organizations_organization" "ocon" {
}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # Look up all operational account IDs via the AWS organizations
  # provider.
  
  assessment_account_ids = [
    for account in data.aws_organizations_organization.ocon.accounts :
    account.id
    if length(regexall("^env\\d+", account.name)) > 0
  ]

  # Find the Users account by name and email
  users_account_id = [
    for account in data.aws_organizations_organization.ocon.accounts :
    account.id if account.name == "Users"
  ][0]
}