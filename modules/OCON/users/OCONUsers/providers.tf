provider "aws" {
  default_tags {
    tags = var.tags
  }
  
  profile = "cool-users-account-admin"
  # profile = "cool-users-provisionaccount"
  region = var.aws_region
}

# Read-only AWS Organizations provider
provider "aws" {
  alias = "organizationsreadonly"
  default_tags {
    tags = var.tags
  }
  
  profile = "cool-master-account-admin"
  # profile = "cool-master-organizationsreadonly"
  region = var.aws_region
}