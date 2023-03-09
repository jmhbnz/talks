# RHEL 9.0
data "aws_ami" "rhel_9_0" {
  most_recent = true

  owners = ["309956199498"] // Red Hat's Account ID

  filter {
    name   = "name"
    values = ["RHEL-9.0*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
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

# RHEL 8.7
data "aws_ami" "rhel_8_7" {
  most_recent = true

  owners = ["309956199498"] // Red Hat's Account ID

  filter {
    name   = "name"
    values = ["RHEL-8.7*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
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
