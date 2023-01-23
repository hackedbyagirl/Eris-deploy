# ------------------------------------------------------------------------------
# Decliration of "Create VPC" Variables
#   - VPC CIDR Range
#   - VPC Public Subnet CIDR Range
#   - IPs allowed for security group
#
# If want to change defaults, assigned variables can be overriden in vars.auto.tfvars
# ------------------------------------------------------------------------------
variable "vpc_cidr" {
    type = string
    description = "CIDR Block Range Assigned to VPC"
    default = "172.31.0.0/16"
}

variable "public_cidr" {
    type = string
    description = "VPC Subnet Resource CIDR Range"
    default = "172.31.0.0/24"
}

variable "sc_name" {
    type = string
    description = "Security Group Name"
    default = "offsec-ops-sc"  
}

variable "sc_description" {
    type = string
    description = "Description of the Security Group Created"
    default = " " 
}

variable "ips_allowed" {
    type = list
    default = ["0.0.0.0/0"]
}

variable "egress_cidr" {
    type = list
    description = "List of CIDRs for outbound traffic"
    default = ["0.0.0.0/0"]
  
}