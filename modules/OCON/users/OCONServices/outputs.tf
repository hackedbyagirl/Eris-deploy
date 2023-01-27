output "write_assessment_findings_role" {
  value       = aws_iam_role.write_assessment_findings_role
  description = "The IAM role that allows write access to the assessment findings S3 bucket."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
}

output "ssm_session_role" {
  value       = module.session_manager.ssm_session_role
  description = "The IAM role that allows creation of SSM Session Manager sessions to any EC2 instance in this account."
}