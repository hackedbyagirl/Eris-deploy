# ------------------------------------------------------------------------------
#                               IAM Policies
# ------------------------------------------------------------------------------

# -------------------------  AssumeAnyRoleAnywhere  ----------------------------

// Define AssumeAnyRoleAnywhere IAM Policy Permissions
data "aws_iam_policy_document" "assume_any_role_anywhere_policy_doc" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    resources = [
      "arn:aws:iam::*:role/*"
    ]
  }
}

// Create IAM Policy: AssumeAnyRoleAnywhere
resource "aws_iam_policy" "assume_any_role_anywhere_policy" {
  description = var.assume_any_role_anywhere_policy_description
  name        = var.assume_any_role_anywhere_policy_name
  policy      = data.aws_iam_policy_document.assume_any_role_anywhere_policy_doc.json
}

# --------------------------  SelfManagedMFAPolicy  ----------------------------

// Define SelfManagedMFA IAM Policy Permissions
data "aws_iam_policy_document" "self_managed_creds_with_mfa_policy_doc" {
  # Allow users to view their own account information
  statement {
    effect = "Allow"

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListVirtualMFADevices",
    ]

    resources = [
      "*",
    ]
  }

  # Allow users to administer their own passwords
  statement {
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own access keys
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own signing certificates
  statement {
    effect = "Allow"

    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own ssh public keys
  statement {
    effect = "Allow"

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own git credentials
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own virtual MFA device
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:mfa/*",
    ]
  }

  # Allow users to administer their own (non-virtual) MFA device
  statement {
    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Deny all actions but the following if no MFA device is configured
  statement {
    effect = "Deny"

    not_actions = [
      "iam:ChangePassword",
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"

      values = [
        false,
      ]
    }
  }
}

// Create IAM Policy: SelfManagedMFA
resource "aws_iam_policy" "self_managed_creds_with_mfa_policy" {
  description = var.self_managed_creds_with_mfa_policy_description
  name        = var.self_managed_creds_with_mfa_policy_name
  policy      = data.aws_iam_policy_document.self_managed_creds_with_mfa_policy_doc.json
}

# ------------------------  SelfManagedNoMFAPolicy  ----------------------------

// Define SelfManagedNoMFA IAM Policy Permissions
data "aws_iam_policy_document" "self_managed_creds_without_mfa_policy_doc" {
  # Allow users to view their own account information
  statement {
    effect = "Allow"

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListVirtualMFADevices",
    ]

    resources = [
      "*",
    ]
  }

  # Allow users to administer their own passwords
  statement {
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own access keys
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own signing certificates
  statement {
    effect = "Allow"

    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own ssh public keys
  statement {
    effect = "Allow"

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own git credentials
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  # Allow users to administer their own virtual MFA device
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:mfa/*",
    ]
  }

  # Allow users to administer their own (non-virtual) MFA device
  statement {
    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }
}

// Create IAM Policy: SelfManagedNoMFA
resource "aws_iam_policy" "self_managed_creds_without_mfa_policy" {
  description = var.self_managed_creds_without_mfa_policy_description
  name        = var.self_managed_creds_without_mfa_policy_name
  policy      = data.aws_iam_policy_document.self_managed_creds_without_mfa_policy_doc.json
}

# ------------------------------------------------------------------------------
#                                    IAM Group
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ----------------------------------  Godess  ----------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Group: Godesses
resource "aws_iam_group" "godesses" {
  name = var.godesses_group_name
}

// Attach AssumeAnyRoleAnywhere IAM Policy to IAM Group: Godesses
resource "aws_iam_group_policy_attachment" "assume_any_role_anywhere_attachment" {
  group      = aws_iam_group.godesses.name
  policy_arn = aws_iam_policy.assume_any_role_anywhere_policy.arn
}

# ------------------------------------------------------------------------------
#                                    IAM Users
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ---------------------------------  Godess  -----------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM User: Godess
resource "aws_iam_user" "godess" {
  for_each = toset(var.godess_usernames)

  name = each.key
}

// Attach SelfManagedNoMFA IAM Policy to Each IAM User: Godess
resource "aws_iam_user_policy_attachment" "self_managed_creds_without_mfa_attachment" {
  for_each = toset(var.godess_usernames)

  user       = each.key
  policy_arn = aws_iam_policy.self_managed_creds_without_mfa_policy.arn
}

// Put Godess IAM Users in the Godesses Group
resource "aws_iam_user_group_membership" "godesses" {
  for_each = toset(var.godess_usernames)

  user = aws_iam_user.godess.name

  groups = [
    aws_iam_group.godesses.name
  ]
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# --------------------------ProvisionOCONUsersAccount---------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
// Using the predefined module, this will set up a IAM Role and attach the
// required policies and permissions

// Create IAM Role: ProvisionTerraformAccount 
module "provisionaccount" {
  source = "../provision-account"

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  users_account_id                  = data.aws_caller_identity.users.account_id
}
