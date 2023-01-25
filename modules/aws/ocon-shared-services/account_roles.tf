# ------------------------------------------------------------------------------
# Creates IAM Policies that will be associated with created IAM Roles
#  
#   IAM Policies:
#   - WriteAssessmentFindings
#   - ProvisionSessionManager
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#             IAM Role: WriteAssessmentFindings
# ------------------------------------------------------------------------------

resource "aws_iam_role" "assessment_findings_bucket_write" {
  assume_role_policy = data.aws_iam_policy_document.asseessment_account_assume_role_doc.json
  description        = var.assessment_findings_bucket_write_role_description
  name               = var.assessment_findings_bucket_write_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "assessment_findings_bucket_write" {
  policy_arn = aws_iam_policy.assessment_findings_bucket_write.arn
  role       = aws_iam_role.assessment_findings_bucket_write.name
}

# ------------------------------------------------------------------------------
#             IAM Role: ProvisionSessionManager
# ------------------------------------------------------------------------------
# Attach the IAM policy to Role
resource "aws_iam_role_policy_attachment" "provisionssmsessionmanager_policy_attachment" {
  policy_arn = aws_iam_policy.provisionssmsessionmanager_policy.arn
  role       = module.provisionaccount.provisionaccount_role.name
}