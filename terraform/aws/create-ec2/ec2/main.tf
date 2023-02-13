# Get Availability Zones
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a Private Key and encode it as PEM.
resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_sensitive_file" "aws_key" {
  # content  = "${nonsensitive( tls_private_key.key.private_key_pem )}"
  content  = "${tls_private_key.key.private_key_pem}"
  filename = "${path.root}/aws_key.pem"
}

# Select a EC2 Instance AMI 
data "aws_ami" "linux_ami" {
    most_recent = true
    owners      = ["${var.ami_owners[var.ami_linux_name]}"]
    filter {
      name   = "name"
      values = ["${local.ami_name_filters[var.ami_linux_name]}"]
    }
    filter {
      name   = "block-device-mapping.volume-size"
      values = ["8"]
    }
    filter {
      name   = "ena-support"
      values = ["true"]
    }
    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }
    filter {
      name   = "architecture"
      values = ["x86_64"]
    }
}

# Create a EC2 Instance 
resource "aws_instance" "node" {
  count                  = var.ec2_count
  instance_type          = var.ec2_type
  ami                    = data.aws_ami.linux_ami.id  # var.ubuntu_ami (ami-0d527b8c289b4af7f ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211129)
  key_name               = aws_key_pair.key_pair.id   # if you have got your own key change this field to a path to your key and comment out 2 resources above 
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnet
  user_data              = templatefile("${path.root}/${local.init_script_file}",{public_key = file("${var.public_key_file_name}")})
  tags = {
    Name = "${var.project_name}-node-${count.index}"
  }
  root_block_device {
    volume_size = var.ec2_volume_size
  }
}

# Create and assosiate an Elastic IP
# resource "aws_eip" "eip" {
#   instance = aws_instance.node[1].id
# }
