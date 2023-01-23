# create_vpc

Creates a VPC, Subnet, Internet Gateway, Route Table and a Route Table association.
- Tag associated is currently `Name:test-build` but should be changed

## Example

```hcl
module "create_vpc" {
  source = "../../modules/aws/create_vpc"

  vpc_cidr = ["XX.XX.XX.XX/16"]
  public_cidr = ["XX.XX.XX.XX/24"]

  sc_name = "<name of security group to create>"
  sc_description = "<Security Group Description>"
  ips_allowed = ["XX.XX.XX.XX/32", "XX.XX.XX.XX/32"]
}
```
## Arguments
| Name | Required | Value Type | Description |
|------|----------|------------|-------------|
| `vpc_cidr` | Yes | String | CIDR Block Range Assigned to VPC |
| `public_cidr` | Yes | String | VPC Subnet Resource CIDR Range |
| `sc_name` | Yes | String | Name of base security group policy you want to create in your VPC. Default is `offsec-ops-sc`|
| `sc_description` | No | String | Description of Security Group. Default is ''|
| `ips_allowed` | No** | String | IPs allowed to SSH into EC2 Instances within VPC. Default is `["0.0.0.0/0"]`|
| `egress_cidr` | No | String | Outbound traffic rules of EC2 Instances within VPC. Default is `["0.0.0.0/0"]`|
 
 **: Highly Recomended to Change

## Outputs
| Name | Value Type | Description |
|------|------------|-------------|
| `vpc_id` | String | ID of the newly created VPC |
| `subnet_id` | String | ID of the newly created VPC associated subnet |

