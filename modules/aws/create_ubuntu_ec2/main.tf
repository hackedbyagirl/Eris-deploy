terraform {
  required_version = ">= 0.11.0"
}

# ------------------------------------------------------------------------------
#             Creates EC2 Resource in AWS to host Ubuntu AMI
# ------------------------------------------------------------------------------

// Assoiciated Security Group that will be assigned
data "aws_security_groups" "offsec" {
  filter {
    name   = "tag:Name"
    values = ["offsec-ops"]
  }
}

resource "random_id" "ubuntu" {
  count       = "${var.deployment_count}"
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  count     = "${var.deployment_count}" 
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ubuntu" {
  count      = "${var.deployment_count}"
  key_name   = "ubuntu-key-${count.index}"
  public_key = "${tls_private_key.ssh.*.public_key_openssh[count.index]}"
}

resource "aws_instance" "ubuntu" {
  count                       = "${var.deployment_count}" 
  
  ami                         = "${var.ami_id}"
  instance_type               = "${var.inst_type}"

  subnet_id                   = "${var.sub_id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = "${data.aws_security_groups.offsec.ids}"
  key_name                    = "${aws_key_pair.ubuntu[count.index].key_name}"

  tags = {
    Name = "ubuntu-${random_id.ubuntu.*.hex[count.index]}",
    Name = "offsec-ops"
  }

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.ssh.*.private_key_pem[count.index]}\" > ../../data/ssh_keys/${self.public_ip} && echo \"${tls_private_key.ssh.*.public_key_openssh[count.index]}\" > ../../data/ssh_keys/${self.public_ip}.pub && chmod 600 ../../data/ssh_keys/*" 
  }
  
  provisioner "local-exec" {
    when    = destroy
    command = "rm ../../data/ssh_keys/${self.public_ip}*"
  }
}
