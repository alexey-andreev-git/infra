# locals {
#   dists = {
#     "ubuntu"        = length([for ami in var.ec2 : ami.ami_id if ami.ami_id == "ubuntu"]) > 0 ? 1 : 0,
#     "amazon_linux"  = length([for ami in var.ec2 : ami.ami_id if ami.ami_id == "amazon_linux"]) > 0 ? 1 : 0
#   }
# }

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*22.04-amd64-*"]
  }
}

data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["137112412989"] # Amazon
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

# data "aws_ami" "centos" {
#   most_recent = true
#   owners      = ["679593333241"] # CentOS
#   filter {
#     name   = "name"
#     values = ["CentOS Linux 8 x86_64 HVM EBS *"]
#   }
# }

# data "aws_ami" "rhel" {
#   most_recent = true
#   owners      = ["309956199498"] # Red Hat
#   filter {
#     name   = "name"
#     values = ["RHEL-8*-HVM-*"]
#   }
# }

# data "aws_ami" "suse" {
#   most_recent = true
#   owners      = ["013907871322"] # SUSE
#   filter {
#     name   = "name"
#     values = ["suse-sles-15-sp3-v2021*"]
#   }
# }

# data "aws_ami" "debian" {
#   most_recent = true
#   owners      = ["379101102735"] # Debian
#   filter {
#     name   = "name"
#     values = ["debian-10-amd64-*"]
#   }
# }

data "aws_ami" "windows" {
  # count = local.dists["windows"]
  most_recent = true
  owners      = ["801119661308"] # Microsoft
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

locals {
  ami = {
    # "ubuntu"       = length(data.aws_ami.ubuntu) == 1 ? data.aws_ami.ubuntu : null,
    # "amazon_linux" = length(data.aws_ami.amazon_linux) == 1 ? data.aws_ami.amazon_linux : null
    "amazon"  = data.aws_ami.amazon,
    # "centos"  = data.aws_ami.centos,
    # "debian"  = data.aws_ami.debian,
    # "rhel"    = data.aws_ami.rhel,
    # "suse"    = data.aws_ami.suse,
    "ubuntu"  = data.aws_ami.ubuntu,
    "windows" = data.aws_ami.windows
  }
}
