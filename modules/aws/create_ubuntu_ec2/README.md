# create_ubuntu_ec2
Creates an EC2 Instance using a base AWS Ubuntu AMI. Can be used for various deployments. SSH keys for each instance created will will be outputted to the `ssh_keys` folder.
Current Associated Tags
- ubuntu-{instance-ID}
- `Name: offsec-ops`

## Example
```hcl
module "ubuntu_ec2" {
    source = "../modules/aws/create_ubuntu_ec2"

    sub_id = "<VPC Subnet ID>"
}
```
## Arguments
| Name | Required | Value Type | Description |
|------|----------|------------|-------------|
| `sub_id` | Yes | String | Subnet ID to create instance in. No default. |
| `ami_id` | Yes | String | AMI ID of Ubuntu AMI. Default is AWS's `Ubuntu Server LTS 20.04 LTS` |
| `deployment_count` | No | Integer | Number of instances to launch. Defauls to `1` |
| `inst_type` | No | String | Instance type to launch. Defaults to `t2.medium`|

## Outputs 
| Name | Value Type | Description |
|------|------------|-------------|
| `ips` | List | IPs of created instances |
| `ssh_user` | String | SSH user for inital access of instance|

## Potential Integration
- Availibility Zone