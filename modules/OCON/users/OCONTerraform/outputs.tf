# ------------------------------------------------------------------------------
# Output Information
# ------------------------------------------------------------------------------
## Infrastructure
output "s3_bucket_name" {
  value       = aws_s3_bucket.tf_bucket
  description = "Name of S3 bucket where Terraform state information will be stored."
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.tf_dynamodb
  description = "Name of DynamoDB table that to be used for Terraform state locking."
}

## IAM Roles
output "terraform_domainmanger_role" {
  value       = aws_iam_role.terraform_domainmanger_role
  description = "The IAM role that allows sufficient access to the the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

output "pca_terraform_role" {
  value       = aws_iam_role.pca_terraform_role
  description = "The IAM role that allows sufficient access to the the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

output "terraformresources_role" {
  value       = aws_iam_role.terraformresources_role
  description = "The IAM role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account."
}

output "read_terraform_state_role" {
  value       = aws_iam_role.read_terraform_state_role
  description = "The IAM role that allows read-only access to the S3 bucket where Terraform state is stored."
}



