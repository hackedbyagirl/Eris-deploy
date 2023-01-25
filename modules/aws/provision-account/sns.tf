# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the SNS actions necessary
# to create and subscribe to a generic notification topic for
# CloudWatch alarms in this account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "sns" {
  statement {
    actions = [
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:GetSubscriptionAttributes",
      "sns:GetTopicAttributes",
      "sns:ListTagsForResource",
      "sns:SetTopicAttributes",
      "sns:Subscribe",
      "sns:Unsubscribe",
    ]
    resources = ["*"]
  }

}

resource "aws_iam_policy" "sns" {
  description = var.sns_policy_description
  name        = var.sns_policy_name
  policy      = data.aws_iam_policy_document.sns.json
}