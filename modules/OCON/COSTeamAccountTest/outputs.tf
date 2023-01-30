## IAM Groups and Roles
output "godess_users" {
  value       = aws_iam_user.godess
  description = "The IAM users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
}

output "godesses_group" {
  value       = aws_iam_group.godesses
  description = "The IAM group containing the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
}

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

output "assume_any_role_anywhere_policy" {
  value       = aws_iam_policy.assume_any_role_anywhere_policy
  description = "The IAM role that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
}

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

output "selfmanagedcredswithmfa_policy" {
  value       = aws_iam_policy.self_managed_creds_with_mfa_policy
  description = "The IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
}

output "selfmanagedcredswithoutmfa_policy" {
  value       = aws_iam_policy.self_managed_creds_without_mfa_policy
  description = "The IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
}
