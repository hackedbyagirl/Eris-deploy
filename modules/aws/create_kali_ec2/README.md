# create_kali_ec2
Creates an EC2 Instance, using a pre-configured kali AMI, to be used as an external penetration testing box. SSH keys for each instance will be outputted to the `ssh_keys` folder.
Current Associated Tags
- kali-{instance-ID}
- `Name:test-build` but should be changed

## Example
```hcl
module "kali_ec2" {
    source = "../modules/aws/create_kali_ec2"

    subnet_id = "<VPC Subnet ID>"
}
```
## Arguments
| Name | Required | Value Type | Description |
|------|----------|------------|-------------|
| `sub_id` | Yes | String | Subnet ID to create instance in. |
| `deployment_count` | No | Integer | Number of instances to launch. Defauls to `1` |
| `inst_type` | No | String | Instance type to launch. Defaults to `t2.medium`|

## Outputs 
| Name | Value Type | Description |
|------|------------|-------------|
| `ips` | List | IPs of created instances |
| `ssh_user` | String | SSH user for inital access of instance|

## Potential Integration
- Availibility Zone