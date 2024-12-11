module "vpcs" {
  source         = "./modules/vpcs"
  for_each       = local.deployments_data
  deployment_id  = each.key
  id             = contains(keys(each.value.vpc), "id") ? each.value.vpc.id : null
  cidr_block     = contains(keys(each.value.vpc), "cidr_block") ? each.value.vpc.cidr_block : null # each.value.vpc.cidr_block
  tags_name      = "vpc-${each.key}"
} 
