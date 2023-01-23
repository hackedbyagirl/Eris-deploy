# ------------------------------------------------------------------------------
#                     Creates VPC Module Outputs for Printing
# ------------------------------------------------------------------------------
output "vpc_id" {
  value = "${aws_vpc.offsec.id}"
}

output "arn_id" {
  value = "${aws_vpc.offsec.arn}"
}

output "subnet_id" {
  value = "${aws_subnet.offsec.id}"
}