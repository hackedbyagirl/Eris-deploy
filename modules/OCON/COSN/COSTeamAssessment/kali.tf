terraform {
  required_version = ">= 0.11.0"
}

# ------------------------------------------------------------------------------
# Creates EC2 Resource in AWS to host Kali AMI
#   - Searches for Kali AMI
#   - Creates Instance Based off AMI found in Search Parameter
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#  Retreive Kali AMI
# ------------------------------------------------------------------------------

data "aws_ami" "kali" {
  filter {
    name = "name"
    values = ["Kali-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ------------------------------------------------------------------------------
#  Generate Access Keys
# ------------------------------------------------------------------------------
resource "random_id" "kali" {
  count       = "${var.deployment_count}" // varible
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  count     = "${var.deployment_count}" //variable
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kali" {
  count      = "${var.deployment_count}" //variable
  key_name   = "kali-key-${count.index}"
  public_key = "${tls_private_key.ssh.*.public_key_openssh[count.index]}"
}

# ------------------------------------------------------------------------------
#  Create and Deploy Kali EC2
# ------------------------------------------------------------------------------
resource "aws_instance" "kali" {
  count                       = "${var.deployment_count}" // variable
  
  ami                         = "${data.aws_ami.kali.id}"
  instance_type               = "${var.inst_type}" //variable
  associate_public_ip_address = true
  subnet_id                   = "${aws_subnet.offsec.id}"
  key_name                    = "${aws_key_pair.kali[count.index].key_name}"

  tags = var.tags

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.ssh.*.private_key_pem[count.index]}\" > ../../data/ssh_keys/${self.public_ip} && echo \"${tls_private_key.ssh.*.public_key_openssh[count.index]}\" > ../../data/ssh_keys/${self.public_ip}.pub && chmod 600 ../../data/ssh_keys/*" 
  }
  
  provisioner "local-exec" {
    when    = destroy
    command = "rm ../../data/ssh_keys/${self.public_ip}*"
  }
}