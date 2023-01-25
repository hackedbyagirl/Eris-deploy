# ------------------------------------------------------------------------------
# Creates IAM Policies that will be associated with created IAM Roles
#  
#   IAM Policies:
#   - WriteAssessmentFindings
#   - ProvisionSessionManager
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#             IAM policy: WriteAssessmentFindings
# ------------------------------------------------------------------------------
resource "aws_iam_policy" "assessment_findings_bucket_write" {
  description = var.assessment_findings_bucket_write_role_description
  name        = var.assessment_findings_bucket_write_role_name
  policy      = data.aws_iam_policy_document.assessment_findings_bucket_write.json
}

# ------------------------------------------------------------------------------
#             IAM policy:  ProvisionSessionManager
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "provisionssmsessionmanager_policy" {
  description = var.provisionssmsessionmanager_policy_description
  name        = var.provisionssmsessionmanager_policy_name
  policy      = data.aws_iam_policy_document.provisionssmsessionmanager_policy_doc.json
}