# ------------------------------------------------------------------------------
#                               IAM Policies and Roles
# ------------------------------------------------------------------------------

// Define AssumeRole IAM Policy Permissions
data "aws_iam_policy_document" "assume_role_policy_doc" {
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

// Define Assessments_AssumeRole IAM Policy Permissions
data "aws_iam_policy_document" "assessment_account_assume_role_policy_doc" {
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
# ------------------------------------------------------------------------------
# ---------------------------WriteAssessmentFindings---------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: WriteAssessmentFindings 
resource "aws_iam_role" "write_assessment_findings_role" {
  assume_role_policy = data.aws_iam_policy_document.assessment_account_assume_role_doc.json
  description        = var.write_assessment_findings_role_description
  name               = var.write_assessment_findings_role_name
}

// Define AccessTerraformResources IAM Role and Policy Permissions
data "aws_iam_policy_document" "write_assessment_findings_policy_doc" {
  statement {
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${var.assessment_findings_bucket_name}/${var.assessment_findings_bucket_object_key_pattern}",
    ]
  }
}

// Create IAM Policy: AccessTerraformResources
resource "aws_iam_policy" "write_assessment_findings_policy" {
  description = var.write_assessment_findings_role_description
  name        = var.write_assessment_findings_role_name
  policy      = data.aws_iam_policy_document.write_assessment_findings_policy_doc.json
}

// Attach the IAM policy to the IAM Role: AccessTerraformResources
resource "aws_iam_role_policy_attachment" "write_assessment_findings" {
  policy_arn = aws_iam_policy.write_assessment_findings_policy.arn
  role       = aws_iam_role.write_assessment_findings_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# --------------------------ProvisionOCONServicesAccount-------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
// Using the predefined module, this will set up a IAM Role and attach the
// required policies and permissions

// Create IAM Role: ProvisionOCONServicesAccount
module "provisionaccount" {
  source = "../provision-account"

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  users_account_id                  = local.users_account_id
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ----------------------------ProvisionSessionManager---------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
// Using the predefined module, this will set up access to AWS Session Manager
// to configure logging for an AWS account 

// Create IAM Role: ProvisionSessionManager
module "session_manager" {
  providers = {
    aws = aws
  }
  source = "../session-manager"

  other_accounts = [
    local.users_account_id,
  ]
}

// Define ProvisionSessionManager IAM Role and Policy Permissions
data "aws_iam_policy_document" "provision_sessionmanager_policy_doc" {
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

// Create IAM Policy: ProvisionSessionManager
resource "aws_iam_policy" "provision_sessionmanager_policy" {
  description = var.provision_sessionmanager_policy_description
  name        = var.provision_sessionmanager_policy_name
  policy      = data.aws_iam_policy_document.provision_sessionmanager_policy_doc.json
}

// Attach the IAM policy to the IAM Role: ProvisionOCONServicesAccount
resource "aws_iam_role_policy_attachment" "provision_sessionmanager_policy_attachment" {
  policy_arn = aws_iam_policy.provision_sessionmanager_policy.arn
  role       = module.provisionaccount.provisionaccount_role.name
}
