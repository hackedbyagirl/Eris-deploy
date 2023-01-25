# ------------------------------------------------------------------------------
#                                  AWS Configuration
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the Master account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-west-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

# ------------------------------------------------------------------------------
#                           AWS Backend Configuration
# ------------------------------------------------------------------------------

variable "s3_bucket" {
  type        = string
  description = "The AWS S3 Bucket"
  default     = "camelot-ocon-terraform-state"
}

variable "s3_profile" {
  type        = string
  description = "AWS S3 Bucket Profile"
  default     = "ocon-terraform-backend"
}

variable "s3_key" {
  type        = string
  default     = "ocon-accounts/master.tfstate"  
}

variable "dynamodb_name" {
  type        = string
  description = "AWS DynamoDB Table"
  default     = "terraform-state-lock"
}

# ------------------------------------------------------------------------------
#                           User/Group Configuration
# ------------------------------------------------------------------------------
variable "godess_usernames" {
  type        = list(string)
  description = "The usernames associated with the god-like accounts to be created, which are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account.  The format first.last is recommended.  Example: [\"firstname1.lastname1\",  \"firstname2.lastname2\"]."
}

variable "godess_group_name" {
  type        = string
  description = "The name of the group to be created for the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
  default     = "godesses"
}

# ------------------------------------------------------------------------------
#                         IAM Documents, Policies, and Roles
# ------------------------------------------------------------------------------

variable "assume_any_role_anywhere_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  default     = "Allow assumption of any role in any account, so long as it has a trust relationship with the Users account."
}

variable "assume_any_role_anywhere_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  default     = "AssumeAnyRoleAnywhere"
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows access to provision all AWS resources in the Users account."
  default     = "Allows sufficient access to provision all AWS resources in the Users account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Users account."
  default     = "ProvisionAccount"
}

variable "self_managed_creds_with_mfa_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  default     = "Allows sufficient access for users to administer their own user accounts, requiring multi-factor authentication (MFA)."
}

variable "self_managed_creds_with_mfa_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  default     = "SelfManagedCredsWithMFA"
}

variable "self_managed_creds_without_mfa_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  default     = "Allows sufficient access for users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
}

variable "self_managed_creds_without_mfa_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  default     = "SelfManagedCredsWithoutMFA"
}

