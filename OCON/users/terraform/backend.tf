terraform {
  backend "s3" {
    encrypt        = true
    bucket         = var.s3_bucket
    dynamodb_table = var.dynamodb_name
    profile        = var.s3_profile
    region         = var.aws_region
    key            = var.s3_key
  }
}