# ------------------------------------------------------------------------------
#                     Creates VPC Module Outputs for Printing
# ------------------------------------------------------------------------------

output "ips" {
  value = ["${aws_instance.ubuntu.*.public_ip}"]
}

output "ssh_user" {
  value = "camelot"
}
