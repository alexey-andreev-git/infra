module "internet_gw" {
  source   = "./modules/internet_gw"
  for_each = local.deployments_data
  vpc      = module.vpcs[each.key].vpcs.id
  igws     = each.value.vpc.internet_gateways
}
