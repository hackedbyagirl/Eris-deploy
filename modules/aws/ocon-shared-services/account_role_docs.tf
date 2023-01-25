# ------------------------------------------------------------------------------
# Defines IAM Policies 
#
#   IAM Policy Documents:
#   - Allow Single Sign-On (SSO) (sso_policy)
#   - Creates Routing Table for VPC
#   - Associates Route Table to Public Subnet
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#                 IAM Policy Document - AssumeOperationsAccount
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "asseessment_account_assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.assessment_account_ids
    }
  }
}

# ------------------------------------------------------------------------------
#                 IAM Policy Document - WriteAssessmentFindings
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assessment_findings_bucket_write" {
  statement {
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${var.assessment_findings_bucket_name}/${var.assessment_findings_bucket_object_key_pattern}",
    ]
  }
}

# ------------------------------------------------------------------------------
#                 IAM Policy Document - AssumeRole
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      identifiers = [
        local.users_account_id,
      ]
    }
  }
}

# ------------------------------------------------------------------------------
#                 IAM Policy Document - ProvisionSessionManager
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionssmsessionmanager_policy_doc" {
  # SSM document permissions
  statement {
    actions = [
      "ssm:AddTagsToResource",
      "ssm:CreateDocument",
      "ssm:DeleteDocument",
      "ssm:DescribeDocument*",
      "ssm:GetDocument",
      "ssm:UpdateDocument*",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.sharedservices.account_id}:document/SSM-SessionManagerRunShell",
    ]
  }

  # CloudWatch log group permissions
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DescribeLogGroups",
      "logs:ListTagsLogGroup",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    actions = [
      "logs:DeleteLogGroup",
      "logs:PutRetentionPolicy",
      "logs:TagLogGroup",
    ]

    resources = [
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.sharedservices.account_id}:log-group:${module.session_manager.ssm_session_log_group.name}:*",
    ]
  }
}