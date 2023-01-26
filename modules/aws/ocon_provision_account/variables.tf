# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ------------------------------------------------------------------------------

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the new account (e.g. \"Allows sufficient permissions to provision all AWS resources in the DNS account.\")."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the new account (e.g. \"ProvisionAccount\")."
}

variable "users_account_id" {
  type        = string
  description = "The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the new account."
}

# ------------------------------------------------------------------------------
#                                AWS Configuration
# ------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the new account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

# ------------------------------------------------------------------------------
#                         IAM Roles, Policies, and Documents
# ------------------------------------------------------------------------------

variable "iampolicy_attachment" {
  type = string
  description = "IAM Full Access Policy Attackment"
  default = "arn:aws:iam::aws:policy/IAMFullAccess"
  
}

variable "servicequotas_policy_attachment" {
  type = string
  description = "Service Quotas Full Access Policy Attachment"
  default = "arn:aws:iam::aws:policy/ServiceQuotasFullAccess"
  
}