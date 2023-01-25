# This is the "default" provider that is used to create resources
# inside the Terraform account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  # Use this profile once the Terraform account has been bootstrapped.
  # profile = "ocon-terraform-provisionaccount"
  profile = "ocon-terraform-account-admin"
  region = var.aws_region
}

# Read-only AWS Organizations provider
provider "aws" {
  alias = "organizationsreadonly"
  default_tags {
    tags = var.tags
  }
  # Use this profile once the Master account has been bootstrapped.
  # profile = "ocon-master-organizationsreadonly"
  profile = "ocon-master-account-admin"
  region = var.aws_region
}