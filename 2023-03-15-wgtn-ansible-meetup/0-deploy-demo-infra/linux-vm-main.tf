# Create elastic ip for the ec2 instance
resource "aws_eip" "linux-eip" {
  count = 4
  vpc   = true
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-eip"
    Environment = var.app_environment
  }
}

# Define the security group for the ec2 instance
resource "aws_security_group" "aws-linux-sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
  description = "Allow incoming HTTP connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTPS connections"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
    Environment = var.app_environment
  }
}

# Create EC2 Instance
resource "aws_instance" "linux-server" {
  count                       = 1
  ami                         = data.aws_ami.rhel_8_7.id
  instance_type               = var.linux_instance_type
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.aws-linux-sg.id]
  associate_public_ip_address = var.linux_associate_public_ip_address
  source_dest_check           = false
  key_name                    = aws_key_pair.key_pair.key_name

  # root disk
  root_block_device {
    volume_size           = var.linux_root_volume_size
    volume_type           = var.linux_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.linux_data_volume_size
    volume_type           = var.linux_data_volume_type
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-server"
    Environment = var.app_environment
  }

  # Ensure the machine has started with a remote exec
  provisioner "remote-exec" {
    inline = ["echo hello world"]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(format("%s.%s", self.key_name, "pem"))
    }
  }
}

# Associate Elastic IP to Linux Server
resource "aws_eip_association" "linux-eip-association" {
  count         = 1
  instance_id   = aws_instance.linux-server[count.index].id
  allocation_id = aws_eip.linux-eip[count.index].id
}
