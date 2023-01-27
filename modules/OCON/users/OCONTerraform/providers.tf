# This is the "default" provider that is used to create resources
# inside the Terraform account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  profile = "ocon-terraform-account-admin"
  # profile = "ocon-terraform-provisionaccount"
  region = var.aws_region
}

# Read-only AWS Organizations provider
provider "aws" {
  alias = "organizationsreadonly"
  default_tags {
    tags = var.tags
  }
  profile = "ocon-master-account-admin"
  # profile = "ocon-master-organizationsreadonly"
  region = var.aws_region
}