# ------------------------------------------------------------------------------
#                             REQUIRED PARAMETERS
# ------------------------------------------------------------------------------
variable "godess_usernames" {
  type        = list(string)
  description = "The usernames associated with the godess-like accounts to be created, which are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account.  The format first.last is recommended.  Example: [\"firstname1.lastname1\",  \"firstname2.lastname2\"]."
}

variable "s3_bucket" {
  type        = string
  description = "The name to use for the S3 bucket that will store the Terraform state."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

# ------------------------------------------------------------------------------
#                                  AWS Configuration
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the Master account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-west-1"
}

# ------------------------------------------------------------------------------
#                              AWS User Configuration
# ------------------------------------------------------------------------------
variable "godesses_group_name" {
  type        = string
  description = "The name of the group to be created for the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
  default     = "godesses"
}

# ------------------------------------------------------------------------------
#                                  AWS Backend 
# ------------------------------------------------------------------------------
variable "s3_profile" {
  type = string
  description = "AWS S3 Bucket Profile"
  default = "costeam-admin"
  #default = "ocon-terraform-backend"
}

variable "s3_key" {
  type = string
  description = "AWS S3 Bucket Key"
  default = "costeam-accounts/terraform.tfstate"
}

variable "dynamodb_table_name" {
  type        = string
  description = "The name to use for the DynamoDB table that will be used for Terraform state locking."
  default     = "terraform-state-lock"
}

variable "dynamodb_table_read_capacity" {
  type        = number
  description = "The number of read units for the DynamoDB table that will be used for Terraform state locking."
  default     = 20
}

variable "dynamodb_table_write_capacity" {
  type        = number
  description = "The number of write units for the DynamoDB table that will be used for Terraform state locking."
  default     = 20
}

# ------------------------------------------------------------------------------
#                             Project Management
# ------------------------------------------------------------------------------

variable "domainmanager_terraform_projects" {
  type        = list(string)
  description = "The list of project names that contain Domain Manager-related Terraform code (e.g. [\"my-domain-manager-project\"])."
  default     = []
}

variable "pca_terraform_projects" {
  type        = list(string)
  description = "The list of project names that contain PCA-related Terraform code (e.g. [\"my-pca-project\"])."
  default     = []
}

# ------------------------------------------------------------------------------
#                         IAM Roles, Policies, and Documents
# ------------------------------------------------------------------------------

# Policy: AssumeAnyRoleAnywhere
variable "assume_any_role_anywhere_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  default     = "AssumeAnyRoleAnywhere"
}

variable "assume_any_role_anywhere_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  default     = "Allow assumption of any role in any account, so long as it has a trust relationship with the Users account."
}


# Policy: SelfManagedMFA
variable "self_managed_creds_with_mfa_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  default     = "SelfManagedMFA"
}

variable "self_managed_creds_with_mfa_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  default     = "Allows sufficient access for users to administer their own user accounts, requiring multi-factor authentication (MFA)."
}


# Policy: SelfManagedNoMFA
variable "self_managed_creds_without_mfa_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  default     = "SelfManagedNoMFA"
}

variable "self_managed_creds_without_mfa_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  default     = "Allows sufficient access for users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
}


# Role: AccessTerraformResources
variable "terraformresources_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "AccessTerraformResources"
}

variable "terraformresources_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}


# Policy
variable "provisionnetworking_policy_name" {
  type        = string
  description = "IAM policy that allows all of the permissions necessary to provision the networking layer in the COSTeamAccount account."
  default     = "ProvisionNetworkPolicy"
}

variable "provisionnetworking_policy_description" {
  type        = string
  description = "IAM policy that allows all of the permissions necessary to provision the networking layer in the COSTeamAccount account."
  default     = "Provis"
}


# Role: ReadTerraformState
variable "read_terraform_state_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored."
  default     = "ReadTerraformState"
}

variable "read_terraform_state_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored."
  default     = "Allows read-only access to the S3 bucket where Terraform state is stored."
}