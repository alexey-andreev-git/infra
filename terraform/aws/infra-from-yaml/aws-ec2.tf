module "ec2" {
  source   = "./modules/ec2"
  for_each = local.deployments_data
  subnet   = module.subnets[each.key]
  sgs      = module.sgs[each.key]
  ec2      = each.value.vpc.ec2
}
