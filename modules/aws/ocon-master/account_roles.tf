# ------------------------------------------------------------------------------
# Creates and defines IAM Roles that will be applied to 
# ocon-master-admin-account 
#
#   IAM Roles:
#   - SSO: Allow Single Sign-On (SSO)
#   - OrganizationReadOnly: Read-only access to all AWS Organizations info
#   - AdditionalPermissions: Provision AWS accounts via ControlTower
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# IAM Role - SSO-Role: Permission to administer Single Sign-On (SSO)
# ------------------------------------------------------------------------------

resource "aws_iam_role" "sso_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_users_doc.json
  description        = var.sso_role_description
  name               = var.sso_role_name
}

// Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "sso_policy_attachment" {
  policy_arn = aws_iam_policy.sso_policy.arn
  role       = aws_iam_role.sso_role.name
}

# ------------------------------------------------------------------------------
# IAM Role - Organization-read-only: Read-only access to all AWS Organizations 
#            information.
# ------------------------------------------------------------------------------
resource "aws_iam_role" "org_readonly_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.org_readonly_role_description
  name               = var.org_readonly_role_name
}

// Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "org_readonly_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSOrganizationsReadOnlyAccess"
  role       = aws_iam_role.org_readonly_role.name
}

# ------------------------------------------------------------------------------
# IAM Role - AdditionalPermissions: Sets permissions to provision AWS accounts
#                                   via Control Tower.
#
# Control Tower User Guide:
# https://docs.aws.amazon.com/controltower/latest/userguide/roles-how.html#automated-provisioning
#
# ------------------------------------------------------------------------------

resource "aws_iam_role" "controltoweradmin_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_users_control_tower_doc.json
  description        = var.controltoweradmin_role_description
  // This role requires the permissions below in addition to the standard
  // AWS policies (attached further below) to function as intended.
  inline_policy {
    name   = "AdditionalControlTowerPermissionsPolicy"
    policy = data.aws_iam_policy_document.additionalpermissions_policy.json
  }
  // Using the largest possible maximum session duration value of 12 hours
  // since this role can be used to provision many AWS accounts consecutively
  // and it may take up to 30 minutes for each account to be provisioned (it
  // is currently not possible to provision more than one account at a time
  // via Control Tower).
  max_session_duration = 43200 # 12 hours
  name                 = var.controltoweradmin_role_name
}

// Attach necessary IAM policies to the role
resource "aws_iam_role_policy_attachment" "organizationsfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSOrganizationsFullAccess"
  role       = aws_iam_role.controltoweradmin_role.name
}

resource "aws_iam_role_policy_attachment" "servicecatalogadminfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogAdminFullAccess"
  role       = aws_iam_role.controltoweradmin_role.name
}

# ------------------------------------------------------------------------------
# Create the IAM role that allows read-only access to all AWS
# Organizations information.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "org_readonly_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.org_readonly_role_description
  name               = var.org_readonly_role_name
}

// Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "organizationsreadonly_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSOrganizationsReadOnlyAccess"
  role       = aws_iam_role.org_readonly_role.name
}