terraform {
  # We want to hold off on 1.1 or higher until tested
  required_version = "~> 1.0"
  required_providers {
    # Version 3.38.0 of the Terraform AWS provider is the first
    # version to support default tags.
    # https://www.hashicorp.com/blog/default-tags-in-the-terraform-aws-provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.38"
    }
  }
}