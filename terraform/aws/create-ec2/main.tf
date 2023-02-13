module "network" {
  source          = "./network"
  access_ip       = var.access_ip
  vpc_cidr        = local.vpc_cidr
  security_groups = local.security_groups
  project_name    = var.project_name
}


module "ec2" {
  source        = "./ec2"
  public_sg     = module.network.public_sg
  public_subnet = module.network.public_subnet
  project_name  = var.project_name
  public_key_file_name = var.public_key_file_name
  ec2_type = var.ec2_type
  ec2_count = var.ec2_count
  ec2_volume_size = var.ec2_volume_size
  ami_linux_name = var.ami_linux_name
  ami_linux_version_major = var.ami_linux_version_major
  ami_linux_version_minor = var.ami_linux_version_minor
}

output "ec2_public_ips" {
  value = module.ec2.ec2_public_ips
}

