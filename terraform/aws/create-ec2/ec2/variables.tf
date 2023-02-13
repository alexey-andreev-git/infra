variable "project_name" {}
variable "public_sg" {}
variable "public_subnet" {}
variable "public_key_file_name" {}
variable "ec2_type" {}
variable "ec2_count" {}
variable "ec2_volume_size" {}
variable "ami_linux_name" {}
variable "ami_linux_version_major" {}
variable "ami_linux_version_minor" {}

variable "ami_owners" {
  type = map
  default = {
    # "ubuntu" = "099720109477"
    # "debian" = "136693071363"
    # "centos" = "679593333241"
    # "rhel"   = "309956199498"
    # "sles"   = "013907871322"
    "ubuntu" = "amazon"
    "debian" = "amazon"
    "centos" = "amazon"
    "rhel"   = "amazon"
    "sles"   = "amazon"
  }
}

# variable "init_script_file" {
#   type = string
#   default = "ec2/userdata.tpl"
# }

locals  {
  init_script_file = "ec2/bootstrap/${var.ami_linux_name}/userdata.tpl"

  ami_name_filters = {
    "ubuntu" = "*ubuntu-*-${var.ami_linux_version_major}.${var.ami_linux_version_minor}-*-server-*"
    "debian" = "debian-${var.ami_linux_version_major}-*"
    "centos" = "CentOS Linux ${var.ami_linux_version_major}*"
    "rhel"   = "*RHEL-${var.ami_linux_version_major}.${var.ami_linux_version_minor}*HVM-*"
    "sles"   = "suse-sles-${var.ami_linux_version_major}-sp5-*-*-*-*"
  }
}

# variable "ubuntu_ami" {
#   type = string
#   default = "ami-0d527b8c289b4af7f" # Ubuntu 20
# }

