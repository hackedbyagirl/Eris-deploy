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
#                         IAM Documents, Policies, and Roles
# ------------------------------------------------------------------------------

variable "sso_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer the Single Sign-On resources in the Master account."
  default     = "Allows sufficient permissions to administer the Single Sign-On resources in the Master account."
}

variable "sso_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer the Single Sign-On resources in the Master account."
  default     = "sso"
}


variable "controltoweradmin_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  default     = "Allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
}

variable "controltoweradmin_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  default     = "ControlTowerAdmin"
}

variable "org_readonly_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows read-only access to all AWS Organizations information in the Master account."
  default     = "Allows read-only access to all AWS Organizations information in the Master account."
}

variable "org_readonly_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows read-only access to all AWS Organizations information in the Master account."
  default     = "org_readonly"
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Master account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
  default     = "ProvisionAccount"
}


