# ------------------------------------------------------------------------------
# Create Ubuntu EC2 Instance in specified VPC Subnet
# ------------------------------------------------------------------------------
module "ubuntu_ec2" {
    source = "../modules/aws/create_ubuntu_ec2"

    sub_id = ""
}

# ------------------------------------------------------------------------------
# Display awesomeness of created EC2 instance
# ------------------------------------------------------------------------------
output "ips" {
    value = "${module.ubuntu_ec2.ips}"
}

output "ssh_user" {
    value = "${module.ubuntu_ec2.ssh_user}"
}
