# This is the "default" provider that is used to create resources
# inside the Master account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  # Use this profile once the account has been bootstrapped.
  profile = "ocon-master-account-admin"
  region = var.aws_region
}

provider "aws" {
  alias = "organizationsreadonly"
  default_tags {
    tags = var.tags
  }
  profile = "cool-master-organizationsreadonly"
  region  = var.aws_region
}