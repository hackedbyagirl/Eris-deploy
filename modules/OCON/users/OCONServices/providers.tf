provider "aws" {
  default_tags {
    tags = var.tags
  }

  profile = "ocon-services-account-admin"
  # profile = "ocon-services-provisionaccount"
  region = var.aws_region
}

# Read-only AWS Organizations provider
provider "aws" {
  alias = "organizationsreadonly"
  default_tags {
    tags = var.tags
  }
  profile = "cool-master-organizationsreadonly"
  region  = var.aws_region
}

