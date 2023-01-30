# ------------------------------------------------------------------------------
#            Resource Deployment Specific IAM Policies and Roles
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ---------------------------AccessTerraformResources---------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: AccessTerraformResources 
resource "aws_iam_role" "terraformresources_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc.json
  description        = var.terraformresources_role_description
  name               = var.terraformresources_role_name
}

// Define AccessTerraformResources IAM Role and Policy Permissions
data "aws_iam_policy_document" "terraform_resources_policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.tf_bucket.arn, 
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.tf_bucket.arn}/*", 
    ]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      aws_dynamodb_table.tf_dynamodb.arn, 
    ]
  }
}

// Create IAM Policy: AccessTerraformResources
resource "aws_iam_policy" "terraformresources_access_policy" {
  description        = var.terraformresources_role_description
  name               = var.terraformresources_role_name
  policy      = data.aws_iam_policy_document.terraform_resources_policy_doc.json
}

// Attach the IAM policy to the IAM Role: AccessTerraformResources
resource "aws_iam_role_policy_attachment" "terraformbackend_policy_attachment" {
  policy_arn = aws_iam_policy.terraformresources_access_policy.arn
  role       = aws_iam_role.terraformresources_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ---------------------AccessDomainManagerTerraformResources--------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: AccessDomainManagerTerraformResources 
resource "aws_iam_role" "terraform_domainmanger_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc.json
  description        = var.terraform_domainmanger_role_description
  name               = var.terraform_domainmanger_role_name
}

// Define AccessDomainManagerTerraformResources IAM Role and Policy Permissions
data "aws_iam_policy_document" "terraform_domainmanger_policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.tf_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    # Any workspace of any project in var.domainmanager_terraform_projects
    resources = [for tf_project in var.domainmanager_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.tf_bucket.arn, tf_project)]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      aws_dynamodb_table.tf_dynamodb.arn,
    ]
  }
}

// Create IAM Policy: AccessDomainManagerTerraformResources
resource "aws_iam_policy" "terraform_domainmanger_policy" {
  description = var.terraform_domainmanger_role_description
  name        = var.terraform_domainmanger_role_name
  policy      = data.aws_iam_policy_document.terraform_domainmanger_policy_doc.json
}

// Attach the IAM policy to the IAM Role: AccessDomainManagerTerraformResources
resource "aws_iam_role_policy_attachment" "terraform_domainmanger_policy_attachment" {
  policy_arn = aws_iam_policy.terraform_domainmanger_policy.arn
  role       = aws_iam_role.terraform_domainmanger_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# -------------------------AccessPCATerraformResources--------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: AccessPCATerraformResources 
resource "aws_iam_role" "pca_terraform_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc.json
  description        = var.pca_terraform_role_description
  name               = var.pca_terraform_role_name
}

// Define AccessPCATerraformResources IAM Role and Policy Permissions
data "aws_iam_policy_document" "pca_terraform_policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.tf_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    # Any workspace of any project in var.pca_terraform_projects
    resources = [for tf_project in var.pca_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.tf_bucket.arn, tf_project)]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      aws_dynamodb_table.tf_dynamodb.arn,
    ]
  }
}

// Create IAM Policy: AccessPCATerraformResources
resource "aws_iam_policy" "pca_terraform_policy" {
  description = var.pca_terraform_role_description
  name        = var.pca_terraform_role_name
  policy      = data.aws_iam_policy_document.pca_terraform_policy_doc.json
}

// Attach the IAM policy to the IAM Role: AccessPCATerraformResources
resource "aws_iam_role_policy_attachment" "pca_terraform_policy_attachment" {
  policy_arn = aws_iam_policy.pca_terraform_policy.arn
  role       = aws_iam_role.pca_terraform_role.name
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# -----------------------------ReadTerraformState-------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

// Create IAM Role: ReadTerraformState 
resource "aws_iam_role" "read_terraform_state_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc.json
  description        = var.read_terraform_state_role_description
  name               = var.read_terraform_state_role_name
}

// Define ReadTerraformState IAM Role and Policy Permissions
data "aws_iam_policy_document" "read_terraform_state_policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.tf_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.tf_bucket.arn}/*",
    ]
  }
}

// Create IAM Policy: ReadTerraformState
resource "aws_iam_policy" "read_terraform_state_policy" {
  description = var.read_terraform_state_role_description
  name        = var.read_terraform_state_role_name
  policy      = data.aws_iam_policy_document.read_terraform_state_policy_doc.json
}

// Attach the IAM policy to the IAM Role: ReadTerraformState
resource "aws_iam_role_policy_attachment" "read_terraform_state_policy_attachment" {
  policy_arn = aws_iam_policy.read_terraform_state_policy.arn
  role       = aws_iam_role.read_terraform_state_role.name
}

# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision the networking layer in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionnetworking_policy_doc" {
  statement {
    actions = [
      "ec2:AllocateAddress",
      "ec2:AssociateRouteTable",
      "ec2:AttachInternetGateway",
      "ec2:CreateFlowLogs",
      "ec2:CreateInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:CreateNetworkAcl",
      "ec2:CreateNetworkAclEntry",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateTransitGateway",
      "ec2:CreateTransitGatewayRoute",
      "ec2:CreateTransitGatewayRouteTable",
      "ec2:CreateTransitGatewayVpcAttachment",
      "ec2:CreateVpc",
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNatGateway",
      "ec2:DeleteNetworkAcl",
      "ec2:DeleteNetworkAclEntry",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DeleteSubnet",
      "ec2:DeleteTransitGateway",
      "ec2:DeleteTransitGatewayRoute",
      "ec2:DeleteTransitGatewayRouteTable",
      "ec2:DeleteTransitGatewayVpcAttachment",
      "ec2:DeleteVpc",
      "ec2:Describe*",
      "ec2:DetachInternetGateway",
      "ec2:DisassociateRouteTable",
      "ec2:GetTransitGatewayRouteTableAssociations",
      "ec2:GetTransitGatewayRouteTablePropagations",
      "ec2:ModifyVpcAttribute",
      "ec2:ReleaseAddress",
      "ec2:ReplaceRoute",
      "ec2:SearchTransitGatewayRoutes",
      "ram:AssociateResourceShare",
      "ram:CreateResourceShare",
      "ram:DeleteResourceShare",
      "ram:DisassociateResourceShare",
      "ram:GetResourceShares",
      "ram:GetResourceShareAssociations",
      "ram:TagResource",
      "ram:UpdateResourceShare",
      "route53:ChangeTagsForResource",
      "route53:CreateHostedZone",
      "route53:DeleteHostedZone",
      "route53:GetChange",
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DescribeLogGroups",
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "provisionnetworking_policy" {
  description = var.provisionnetworking_policy_description
  name        = var.provisionnetworking_policy_name
  policy      = data.aws_iam_policy_document.provisionnetworking_policy_doc.json
}
