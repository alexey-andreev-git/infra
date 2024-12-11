# Separate internet gateway module with defined id and without id
locals {
  igw_fields_list = ["id", "tags_name"]
  igws_struct = {
    for igw_key, igw in var.igws : igw_key => {
      for field in local.igw_fields_list : field => contains(keys(igw), field) ? igw[field] : null
    }
  }
  # Filter subnets with id
  filter_igws_by_id = [for igw_key, igw in local.igws_struct : igw_key if igw.id != null]
  igws_by_id = { for igw_key in local.filter_igws_by_id : igw_key => local.igws_struct[igw_key].id }
  # Filter subnets without id
  filter_igws_wo_id = [for igw_key, igw in local.igws_struct : igw_key if igw.id == null]
  igws_wo_id = { for igw_key in local.filter_igws_wo_id : igw_key => local.igws_struct[igw_key] }
}

# Create internet gateways with defined id
data "aws_internet_gateway" "gw" {
  for_each = local.igws_by_id
  filter {
    name   = "internet-gateway-id"
    values = [each.value.id]
  }
}

# Create internet gateways without defined id
resource "aws_internet_gateway" "gw" {
  for_each = local.igws_wo_id
  vpc_id   = var.vpc
  tags = {
    Name = each.value.tags_name
  }
}

# Merge internet gateways with and without defined id
locals {
  igws_1 = { for igw_key, igw in aws_internet_gateway.gw : igw_key => igw }
  igws_2 = { for igw_key, igw in data.aws_internet_gateway.gw : igw_key => igw }
  igws = merge(local.igws_1, local.igws_2)
}

output "igws" {
  value = local.igws
}
