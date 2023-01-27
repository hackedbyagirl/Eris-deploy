# ------------------------------------------------------------------------------
# Retrieve the information for all accounts in the organization.  This
# is used, for instance, to lookup the account ID for the Users
# account.
#
# Note: Do I need to change for PoC Purpose since I dont have Org
# ------------------------------------------------------------------------------
data "aws_caller_identity" "oconservices" {
}

data "aws_organizations_organization" "ocon" {
  provider = aws.organizationsreadonly
}

locals {
  # Find the Shared Services account name by id.
  sharedservices_account_name = [
    for x in data.aws_organizations_organization.ocon.accounts :
    x.name if x.id == data.aws_caller_identity.oconservices.account_id
  ][0]

  # Determine the dynamic assessment account ("env*") IDs that are the same
  # type (production, staging, etc.) as the Shared Services account.
  sharedservices_account_type = trim(split("(", local.sharedservices_account_name)[1], ")")

  assessment_account_name_regex = format("^env[[:digit:]]+ \\(%s\\)$", local.sharedservices_account_type)

  assessment_account_ids = [
    for account in data.aws_organizations_organization.ocon.non_master_accounts :
    account.id
  if length(regexall(local.assessment_account_name_regex, account.name)) > 0]

  # Find the Users account
  users_account_id = [
    for account in data.aws_organizations_organization.ocon.accounts :
    account.id
    if account.name == "OCONUsers"
  ][0]
}