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

# This bucket is created by cisagov/findings-data-import-terraform.
variable "assessment_findings_bucket_name" {
  type        = string
  description = "The name of the assessment findings S3 bucket."
}

# ------------------------------------------------------------------------------
#                         IAM Documents, Policies, and Roles
# ------------------------------------------------------------------------------
# This bucket is created by cisagov/findings-data-import-terraform.
variable "assessment_findings_bucket_name" {
  type        = string
  description = "The name of the assessment findings S3 bucket."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assessment_findings_bucket_object_key_pattern" {
  type        = string
  description = "The key pattern specifying which objects are allowed to be written to the assessment findings data S3 bucket."
  default     = "*-data.json"
}

variable "assessment_findings_bucket_write_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows write access to the assessment findings S3 bucket."
  default     = "Allows write permissions to the assessment findings S3 bucket."
}

variable "assessment_findings_bucket_write_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows write access to the assessment findings S3 bucket."
  default     = "AssessmentFindingsBucketWrite"
}



variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Shared Services account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  default     = "ProvisionAccount"
}

variable "provisionssmsessionmanager_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  default     = "Allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
}

variable "provisionssmsessionmanager_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  default     = "ProvisionSSMSessionManager"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
