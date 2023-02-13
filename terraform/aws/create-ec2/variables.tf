variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "project_name" {
  type    = string
  default = "my-current-project"
}

variable "access_ip" {
  type = string
}

variable "public_key_file_name" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "ec2_type" {
  type = string
  default = "t2.micro"              # free instance
}

variable "ec2_count" {
  type = number
  default = 1                       # instances count
}

variable "ec2_volume_size" {
  type = number
  default = 15                      # instances volume size
}

variable "ami_linux_name" {
  type = string
  default = "ubuntu"
}

variable "ami_linux_version_major" {
  type = string
  default = "20"
}

variable "ami_linux_version_minor" {
  type = string
  default = "04"
}
