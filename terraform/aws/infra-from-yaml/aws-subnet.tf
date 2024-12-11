module "subnets" {
  source    = "./modules/subnets"
  for_each  = local.deployments_data
  vpc_id    = module.vpcs[each.key].vpcs.id
  subnets   = each.value.vpc.subnets
}
