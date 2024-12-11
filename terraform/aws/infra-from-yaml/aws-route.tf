module "route" {
  source    = "./modules/route"
  for_each  = local.deployments_data
  vpc       = module.vpcs[each.key].vpcs
  subnets   = module.subnets[each.key]
  gateways  = module.internet_gw[each.key]
  routes    = each.value.vpc.routes
}
