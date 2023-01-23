terraform {
  required_version = ">= 0.11.0"
}

# ------------------------------------------------------------------------------
# Creates VPC Resource in AWS
#   - Creates VPC Resource
#   - Creates Public Subnet for VPC
#   - Creates Internet Gateway for VPC
#   - Creates Routing Table for VPC
#   - Associates Route Table to Public Subnet
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#                       Creates VPC and Assigns Subnet
# ------------------------------------------------------------------------------

resource "aws_vpc" "offsec" {
  cidr_block = "${var.vpc_cidr}"
  
  tags = {
    Name = "offsec-ops"
  }
}

resource "aws_subnet" "offsec" {
    vpc_id = "${aws_vpc.offsec.id}"
    cidr_block = "${var.public_cidr}"
    
  tags = {
        Name = "offsec-ops"
  }
}

# ------------------------------------------------------------------------------
#                       Set Up VPC Gateway and Routing
# ------------------------------------------------------------------------------
resource "aws_internet_gateway" "offsec" {
    vpc_id = "${aws_vpc.offsec.id}"
}

resource "aws_route_table" "offsec" {
    vpc_id = "${aws_vpc.offsec.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.offsec.id}"
    }
}

resource "aws_route_table_association" "offsec" {
    subnet_id = "${aws_subnet.offsec.id}"
    route_table_id = "${aws_route_table.offsec.id}"
}


