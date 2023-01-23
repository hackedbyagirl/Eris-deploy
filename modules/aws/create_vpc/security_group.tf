# ------------------------------------------------------------------------------
#           Creates a Base Security Group for Offensive Operations
# ------------------------------------------------------------------------------

resource "aws_security_group" "offsec" {
  name = "${var.sc_name}"
  description = "${var.sc_description}"
  vpc_id = "${aws_vpc.offsec.id}"
  
  tags = {
    Name = "offsec-ops"
  }
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = "${var.ips_allowed}"
  }
  
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = "${var.egress_cidr}"
  }
  
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = "${var.egress_cidr}"
  }
}