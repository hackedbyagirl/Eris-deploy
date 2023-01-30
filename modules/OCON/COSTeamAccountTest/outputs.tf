output "assume_any_role_anywhere_policy" {
  value       = aws_iam_policy.assume_any_role_anywhere_policy
  description = "The IAM role that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
}


output "godess_users" {
  value       = aws_iam_user.godess
  description = "The IAM users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
}

output "godesses_group" {
  value       = aws_iam_group.godesses
  description = "The IAM group containing the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
}

output "selfmanagedcredswithmfa_policy" {
  value       = aws_iam_policy.self_managed_creds_with_mfa_policy
  description = "The IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
}

output "selfmanagedcredswithoutmfa_policy" {
  value       = aws_iam_policy.self_managed_creds_without_mfa_policy
  description = "The IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
}