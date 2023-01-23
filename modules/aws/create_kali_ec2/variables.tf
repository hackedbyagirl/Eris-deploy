# ------------------------------------------------------------------------------
# Decliration of "kali instance" Variables
#   - Count of instances to create
#   - Instance type
#   - Subnet ID -- Must Be provided
#
# If want to change defaults, assigned variables can be overriden in vars.auto.tfvars
# ------------------------------------------------------------------------------

variable "sub_id" {}

variable "deployment_count" {
  default = 1
}

variable "inst_type" {
  default = "t2.medium"
}
 
