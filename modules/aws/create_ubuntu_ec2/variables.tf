# ------------------------------------------------------------------------------
# Decliration of "Ubuntu instance" Variables
#   - Count of instances to create
#   - Instance type
#   - Subnet ID -- Must Be provided
#
# If want to change defaults, assigned variables can be overriden in vars.auto.tfvars
# ------------------------------------------------------------------------------

// Module Provided
variable "sub_id" {
  type = string
  default = " "
}
variable "ami_id" {
  type = string
  default = "ami-03e0029f86a2c74c3"
}
variable "deployment_count" {
  type = number
  default = 1
}

variable "inst_type" {
  default = "t2.medium"
}
 
