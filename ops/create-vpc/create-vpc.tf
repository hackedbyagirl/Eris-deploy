terraform {
  required_version = ">= 0.11.0"
}

# ------------------------------------------------------------------------------
# Creates VPC Subnet for Offensive Operations
#   - Uses module "create-vpc"
#   - Outputs data from "create vpc module"
# ------------------------------------------------------------------------------
module "create_vpc" {
  source = "../../modules/aws/create-vpc"
}

# ------------------------------------------------------------------------------
# Display awesomeness VPC Output
# ------------------------------------------------------------------------------
output "vpc_id" {
    value = "${module.create_vpc.vpc_id}"  
}

output "subnet_id" {
    value = "${module.create_vpc.subnet_id}"  
}
