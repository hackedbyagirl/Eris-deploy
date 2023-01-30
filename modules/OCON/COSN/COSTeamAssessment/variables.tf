# ------------------------------------------------------------------------------
#                             REQUIRED PARAMETERS
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

 
# ------------------------------------------------------------------------------
#                                  AWS Configuration
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the Master account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-west-1"
}

# ------------------------------------------------------------------------------
#                           AWS EC2 Configuration
# ------------------------------------------------------------------------------

variable "deployment_count" {
  default = 1
}

variable "inst_type" {
  default = "t2.medium"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {
    Name = "offsec-ops"
    Type = "Assessment"
  }
}