# provisionaccount-role-tf-module #

A Terraform module to create an AWS IAM role with permissions to provision
any IAM resources in an AWS account, and trust a different AWS account so
that the role can be assumed via IAM.

## Usage ##

```hcl
module "provisionaccount" {
  source = "../../modules/provision-account"

  provisionaccount_role_description          = "Allows sufficient permissions to provision all AWS resources in the DNS account."
  provisionaccount_role_name                 = "ProvisionAccount"
  users_account_id                           = "111111111111"
}
```

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |


## Resources ##

| Name | Type |
|------|------|
| [aws_iam_policy.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.provisionaccount_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.iamfullaccess_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.servicequotasfullaccess_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sns_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region where the non-global resources for the new account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the new account (e.g. "Allows sufficient permissions to provision all AWS resources in the DNS account."). | `string` | n/a | yes |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the new account (e.g. "ProvisionAccount"). | `string` | n/a | yes |
| sns\_policy\_description | The description to associate with the IAM policy that allows sufficient permissions to create and subscribe to a generic notification topic for CloudWatch alarms in the new account. | `string` | `"Allows sufficient permissions to create and subscribe to a generic notification topic for CloudWatch alarms in the new account."` | no |
| sns\_policy\_name | The name to assign the IAM policy that allows sufficient permissions to create and subscribe to a generic notification topic for CloudWatch alarms in the new account. | `string` | `"CWAlarmSNSTopicPolicy"` | no |
| users\_account\_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the new account. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in this account. |

## Notes ##