terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "${var.s3_bucket}" # Required module argument
    dynamodb_table = var.dynamodb_table_name
    profile        = var.s3_profile # Changes after init set up
    region         = var.aws_region
    key            = var.s3_key
  }
}