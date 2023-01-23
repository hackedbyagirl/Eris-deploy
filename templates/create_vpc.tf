terraform {
  required_version = ">= 0.11.0"
}

# ------------------------------------------------------------------------------
# Creates VPC and VPC Subnet for Offensive Operations
#   - Creates VPC and Associated Subnet
#   - Creates a base Security Group for Offensive Operations
#   - Outputs data from "create vpc module"
#
# Current Tag: `test-build`
# ------------------------------------------------------------------------------
module "create_vpc" {
  source = "../../modules/aws/create_vpc"

  vpc_cidr = ["XX.XX.XX.XX/16"]
  public_cidr = ["XX.XX.XX.XX/24"]

  sc_name = "<name of security group to create>"
  sc_description = "<Security Group Description>"
  ips_allowed = ["XX.XX.XX.XX/32", "XX.XX.XX.XX/32"]
}

# ------------------------------------------------------------------------------
# Display awesomeness VPC Output
#   - Created VPC ID
#   - VPC associated Subnet ID 
# ------------------------------------------------------------------------------
output "vpc id" {
    value = "${module.create_vpc.vpc_id}"  
}

output "subnet id" {
    value = "${module.create_vpc.subnet_id}"  
}