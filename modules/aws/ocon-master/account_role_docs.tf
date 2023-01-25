# ------------------------------------------------------------------------------
# Defines IAM Policies 
#
#   IAM Policy Documents:
#   - Allow Single Sign-On (SSO) (sso_policy)
#   - Creates Routing Table for VPC
#   - Associates Route Table to Public Subnet
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# IAM Document - SSO-Policy-Doc: Permission to administer Single Sign-On (SSO)
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "sso_policy_doc" {
  statement {
    actions = [
      "identitystore:ListUsers",
      "identitystore:ListGroups",
      "sso:CreateAccountAssignment",
      "sso:DeleteAccountAssignment",
      "sso:DescribeAccountAssignmentCreationStatus",
      "sso:DescribeAccountAssignmentDeletionStatus",
      "sso:DescribePermissionSet",
      "sso:ListAccountAssignments",
      "sso:ListInstances",
      "sso:ListPermissionSets",
      "sso:ListTagsForResource"
    ]

    resources = ["*"]
  }
}

# ------------------------------------------------------------------------------
# IAM Document - Assume-Role-Users-Doc: Allows ONLY the `Users` Account to
#                assume this role
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_users_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      # Delegate access to this role to just the Users account.
      identifiers = [local.users_account_id]
    }
  }
}

# ------------------------------------------------------------------------------
# IAM Document - Assume-Role-Ops-Doc: Allows the `Users` account and all
#                `Operator` accounts to assume this role
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_ops_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      # Delegate access to this role to the Users account and all
      # operator accounts.
      identifiers = concat([local.users_account_id], local.operator_account_ids)
    }
  }
}

# ------------------------------------------------------------------------------
# IAM Document - Assume-Role-CT-Doc: Allows the `Users` account Control Tower
#                to assume this role
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_users_control_tower_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      # Delegate access to this role to the Users account.
      identifiers = [local.users_account_id]
    }

    principals {
      type = "Service"
      # Delegate access to this role to the Control Tower service.
      identifiers = ["controltower.amazonaws.com"]
    }
  }
}

# ------------------------------------------------------------------------------
# IAM Document - AdditionalPermissions-Doc: Sets permissions to provision AWS 
#                accounts via Control Tower.                                   
#
# Control Tower User Guide:
# https://docs.aws.amazon.com/controltower/latest/userguide/roles-how.html#automated-provisioning
#
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "additionalpermissions_policy" {
  statement {
    actions = [
      "controltower:CreateManagedAccount",
      "controltower:DeregisterManagedAccount",
      "controltower:DescribeManagedAccount",
      "ec2:DescribeAvailabilityZones",
      "sso:AssociateProfile",
      "sso:CreateApplicationInstance",
      "sso:CreateProfile",
      "sso:CreateTrust",
      "sso:DescribeRegisteredRegions",
      "sso:GetApplicationInstance",
      "sso:GetPeregrineStatus",
      "sso:GetPermissionSet",
      "sso:GetProfile",
      "sso:GetSSOStatus",
      "sso:GetTrust",
      "sso:ListDirectoryAssociations",
      "sso:ListPermissionSets",
      "sso:ListProfileAssociations",
      "sso:ProvisionApplicationInstanceForAWSAccount",
      "sso:ProvisionApplicationProfileForAWSAccountInstance",
      "sso:ProvisionSAMLProvider",
      "sso:UpdateProfile",
      "sso:UpdateTrust",
      "sso-directory:AddMemberToGroup",
      "sso-directory:CreateUser",
      "sso-directory:DescribeDirectory",
      "sso-directory:DescribeGroups",
      "sso-directory:GetUserPoolInfo",
      "sso-directory:ListMembersInGroup",
      "sso-directory:SearchGroups",
      "sso-directory:SearchGroupsWithGroupName",
      "sso-directory:SearchUsers",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "additionalpermissions_policy" {
  statement {
    actions = [
      "controltower:CreateManagedAccount",
      "controltower:DeregisterManagedAccount",
      "controltower:DescribeManagedAccount",
      "ec2:DescribeAvailabilityZones",
      "sso:AssociateProfile",
      "sso:CreateApplicationInstance",
      "sso:CreateProfile",
      "sso:CreateTrust",
      "sso:DescribeRegisteredRegions",
      "sso:GetApplicationInstance",
      "sso:GetPeregrineStatus",
      "sso:GetPermissionSet",
      "sso:GetProfile",
      "sso:GetSSOStatus",
      "sso:GetTrust",
      "sso:ListDirectoryAssociations",
      "sso:ListPermissionSets",
      "sso:ListProfileAssociations",
      "sso:ProvisionApplicationInstanceForAWSAccount",
      "sso:ProvisionApplicationProfileForAWSAccountInstance",
      "sso:ProvisionSAMLProvider",
      "sso:UpdateProfile",
      "sso:UpdateTrust",
      "sso-directory:AddMemberToGroup",
      "sso-directory:CreateUser",
      "sso-directory:DescribeDirectory",
      "sso-directory:DescribeGroups",
      "sso-directory:GetUserPoolInfo",
      "sso-directory:ListMembersInGroup",
      "sso-directory:SearchGroups",
      "sso-directory:SearchGroupsWithGroupName",
      "sso-directory:SearchUsers",
    ]
    resources = ["*"]
  }
}


