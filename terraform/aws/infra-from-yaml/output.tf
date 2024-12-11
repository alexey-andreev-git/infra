output "region" {
  value = local.aws_region
  
}

# output "deployments_data" { value = local.deployments_data }

# output "vpcs" { value = [for vpc in module.vpcs : vpc] }

# output "subnets" { value = module.subnets }

# output "sgs" { value = module.sgs }

# output "internet_gw" { value = [for igw in module.internet_gw : igw] }

# output "association_rt" { value = module.route }

# output "ec2_amis" { value = [for a in module.ec2 : a.amis] }
# output "ec2_instances_sg" {
#   value = { for k, v in module.ec2 : k => v.sg_test }
# }

# output "ec2_instances" { value = module.ec2 }
