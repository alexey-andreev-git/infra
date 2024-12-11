# Separate security_groups with and without id
locals {
  sg_fields_list = ["id", "inbound_rules", "tag_name"]
  sgs_struct = {
    for sg_key, sg in var.security_groups : sg_key => {
      for field in local.sg_fields_list : field => contains(keys(sg), field) ? sg[field] : null
    }
  }
  # Filter security_groups with id
  filter_sgs_by_id = [for sg_key, sg in local.sgs_struct : sg_key if sg.id != null]
  sgs_by_id = { for sg_key in local.filter_sgs_by_id : sg_key => local.sgs_struct[sg_key].id }
  # Filter security_groups without id
  filter_sgs_wo_id = [for sg_key, sg in local.sgs_struct : sg_key if sg.id == null]
  sgs_wo_id = { for sg_key in local.filter_sgs_wo_id : sg_key => local.sgs_struct[sg_key] }
}

# Create security_groups without id
resource "aws_security_group" "sg" {
  vpc_id   = var.vpc_id
  for_each = local.sgs_wo_id
  name = "${var.deployment_id}-${each.value.tag_name}"
  tags = {
    Name = each.value.tag_name
  }
  dynamic "ingress" {
    for_each = each.value.inbound_rules
    content {
      description = ingress.value.name
      from_port   = ingress.value.ports[0] == "all" ? 0 : tonumber(ingress.value.ports[0])
      to_port     = ingress.value.ports[0] == "all" ? 65535 : tonumber(ingress.value.ports[0])
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.source_ranges
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Get security_groups with id
data "aws_security_group" "sg" {
  for_each = local.sgs_by_id
  filter {
    name   = "security-group-id"
    values = [each.value]
  }
}

# Merge security_groups
locals {
  sgs_1 = { for sg_key, sg in aws_security_group.sg : sg_key => sg.id}
  sgs_2 = { for sg_key, sg in data.aws_security_group.sg : sg_key => sg.id }
  sgs   = merge(local.sgs_1, local.sgs_2)
}

output "sgs" {
  value = local.sgs
}
