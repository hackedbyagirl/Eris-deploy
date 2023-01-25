# ------------------------------------------------------------------------------
# Creates IAM Policies that will be associated with created IAM Roles
#  
#   IAM Policies:

# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#             IAM policy: SelfManagedMFA
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "self_managed_creds_with_mfa" {
  description = var.self_managed_creds_with_mfa_policy_description
  name        = var.self_managed_creds_with_mfa_policy_name
  policy      = data.aws_iam_policy_document.self_managed_creds_with_mfa.json
}

# ------------------------------------------------------------------------------
#             IAM policy: SelfManagedNoMFA
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "self_managed_creds_without_mfa" {
  description = var.self_managed_creds_without_mfa_policy_description
  name        = var.self_managed_creds_without_mfa_policy_name
  policy      = data.aws_iam_policy_document.self_managed_creds_without_mfa.json
}