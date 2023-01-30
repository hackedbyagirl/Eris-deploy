# COSTeam Assessment
## VPC
Creates a VPC, Subnet, Internet Gateway, Route Table and a Route Table association for assessment deployment.
- Tag associated is currently `Name:offsec-ops` and `Type:Asessment`  

# EC2
Creates an EC2 Instance, using a pre-configured kali AMI, to be used as an external penetration testing box. SSH keys for each instance will be outputted to the `ssh_keys` folder.
Current Associated Tags
- `Name:offsec-ops` and `Type:Asessment`


## Example

```hcl
module "assessment" {
  source = "../../modules/OCON/COSN/COSTeamAssessment"

  vpc_cidr = ["XX.XX.XX.XX/16"]
  public_cidr = ["XX.XX.XX.XX/24"]
}
```
## Arguments
| Name | Required | Value Type | Description |
|------|----------|------------|-------------|
| `vpc_cidr` | Yes | String | CIDR Block Range Assigned to VPC |
| `public_cidr` | Yes | String | VPC Subnet Resource CIDR Range |
| `deployment_count` | No | Integer | Number of instances to launch. Defauls to `1` |
| `inst_type` | No | String | Instance type to launch. Defaults to `t2.medium`|
 

## Outputs
| Name | Value Type | Description |
|------|------------|-------------|
| `arn_id` | string | ARN of the VPC |
| `vpc_id` | String | ID of the newly created VPC |
| `sub_id` | String | ID of the newly created VPC associated subnet |
| `ips` | list(string) | IPs of created EC2 Instances |
| `ssh_user` | String | SSH user for inital access of instance|

