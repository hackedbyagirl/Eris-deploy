terraform {
  required_version = ">= 0.11.0"
}

# ------------------------------------------------------------------------------
# Basic External Penetration Testing Template
#   - Kali EC2
#
# Current Tags:
#   - kali-{id}
#   - test-build
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Create Kali EC2 Instance in specified VPC Subnet
# ------------------------------------------------------------------------------
module "kali_ec2" {
    source = "../../modules/aws/create_kali_ec2"

    sub_id = ""
}

# ------------------------------------------------------------------------------
# Display awesomeness of created EC2 instance
# ------------------------------------------------------------------------------
output "ips" {
    value = "${module.kali_ec2.ips}"
}

output "ssh_user" {
    value = "${module.kali_ec2.ssh_user}"
}
