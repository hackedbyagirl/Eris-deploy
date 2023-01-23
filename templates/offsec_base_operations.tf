



# ------------------------------------------------------------------------------
# Sets up High-Level Offsec Operations Infrastructure
#   - Creates VPC and Associated Subnet
#   - Creates a base Security Group for Offensive Operations
#   - Creates a OffSec Operation Server
#   - Creates a Phishing Server
#
# Current Tag: `offsec-ops`
# ------------------------------------------------------------------------------

# 1. Create OffSec VPC Network
# 3. Create base security groups -- Handles EC2 access
# 4. Spin up OffSec Operations Server
# 5. Spin up Phishing Server 

# ------------------------------------------------------------------------------
#             Create VPC for Offensive Security Operations
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
#                 Create Long-Standing Operational Server
# 1. Operational Base Server
# 2. Operational Phishing Server
# ------------------------------------------------------------------------------
module "ubuntu_ec2" {
    source = "../modules/aws/create_ubuntu_ec2"

    deployment_count = 2
    sub_id = "${module.create_vpc.subnet_id}"
}
