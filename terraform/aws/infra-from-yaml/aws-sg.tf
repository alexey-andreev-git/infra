module "sgs" {
  source          = "./modules/sgs"
  for_each        = local.deployments_data
  deployment_id   = each.key
  vpc_id          = module.vpcs[each.key].vpcs.id
  security_groups = each.value.vpc.security_groups
}
