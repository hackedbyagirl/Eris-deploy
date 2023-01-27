# ------------------------------------------------------------------------------
#                             REQUIRED PARAMETERS
# ------------------------------------------------------------------------------
# This bucket is created by cisagov/findings-data-import-terraform.
variable "assessment_findings_bucket_name" {
  type        = string
  description = "The name of the assessment findings S3 bucket."
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
#                           AWS Backend Configuration
# ------------------------------------------------------------------------------

variable "assessment_findings_bucket_object_key_pattern" {
  type        = string
  description = "The key pattern specifying which objects are allowed to be written to the assessment findings data S3 bucket."
  default     = "*-data.json"
}

# ------------------------------------------------------------------------------
#                         IAM Roles, Policies, and Documents
# ------------------------------------------------------------------------------

# Role: WriteAssessmentFindings
variable "write_assessment_findings_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows write access to the assessment findings S3 bucket."
  default     = "WriteAssessmentFindings"
}

variable "write_assessment_findings_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows write access to the assessment findings S3 bucket."
  default     = "Allows write permissions to the assessment findings S3 bucket."
}

# Role: ProvisionOCONServicesAccount
variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  default     = "ProvisionOCONServicesAccount"
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Shared Services account."
}

# Policy: ProvisionSessionManager
variable "provision_sessionmanager_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  default     = "ProvisionSessionManager"
}

variable "provision_sessionmanager_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  default     = "Allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
}
