# This is the "default" provider that is used to create resources
# inside the Master account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  profile = "ocon-master-account-admin"
  # profile = "ocon-master-provisioner"
  region = var.aws_region
}
