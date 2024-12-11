# Separate subnets with and without id
locals {
  subnet_fields_list = ["id", "cidr_block", "availability_zone", "map_public_ip_on_launch", "tags_name"]
  subnets_struct = {
    for subnet_key, subnet in var.subnets : subnet_key => {
      for field in local.subnet_fields_list : field => contains(keys(subnet), field) ? subnet[field] : null
    }
  }
  # Filter subnets with id
  filter_subnets_by_id = [for subnet_key, subnet in local.subnets_struct : subnet_key if subnet.id != null]
  subnets_by_id = { for subnet_key in local.filter_subnets_by_id : subnet_key => local.subnets_struct[subnet_key].id }
  # Filter subnets without id
  filter_subnets_wo_id = [for subnet_key, subnet in local.subnets_struct : subnet_key if subnet.id == null]
  subnets_wo_id = { for subnet_key in local.filter_subnets_wo_id : subnet_key => local.subnets_struct[subnet_key] }
}

# Create subnets without id
resource "aws_subnet" "subnets" {
  for_each                = local.subnets_wo_id
  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block         # should be implemented if cidr_block is undefind:  cidrsubnet(each.value.ip_cidr_range, 8, count.index)
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags = {
    Name = each.value.tags_name
  }
}

# Get subnets with id
data "aws_subnet" "subnets" {
  for_each = local.subnets_by_id
  filter {
    name   = "subnet-id"
    values = [each.value]
  }
}

# Merge subnets
locals {
  subnets_1 = { for subnet_key, subnet in aws_subnet.subnets : subnet_key => subnet }
  subnets_2 = { for subnet_key, subnet in data.aws_subnet.subnets : subnet_key => subnet }
  subnets = merge(local.subnets_1, local.subnets_2)
}

output "subnets" {
  value = local.subnets
}
