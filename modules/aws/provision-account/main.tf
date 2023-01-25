# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient permissions to provision
# all AWS resources in the new account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "provisionaccount_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.provisionaccount_role_description
  name               = var.provisionaccount_role_name
}

resource "aws_iam_role_policy_attachment" "iamfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  role       = aws_iam_role.provisionaccount_role.name
}

# This policy allows us to request changes to default service quotas
resource "aws_iam_role_policy_attachment" "servicequotasfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/ServiceQuotasFullAccess"
  role       = aws_iam_role.provisionaccount_role.name
}

# This policy allows us to create and subscribe to SNS topics
resource "aws_iam_role_policy_attachment" "sns_policy_attachment" {
  policy_arn = aws_iam_policy.sns.arn
  role       = aws_iam_role.provisionaccount_role.name
}