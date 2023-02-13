variable "project_name" {}
variable "vpc_cidr" {}
variable "access_ip" {}
variable "security_groups" {}

variable "enable_dns_hostnames" {
    type = bool
    default = false
}

variable "enable_dns_support" {
    type = bool
    default = true
}

variable "map_public_ip_on_launch" {
    type = bool
    default = true
}

variable "availability_zone_index" {
    default = 0
}