data "aws_subnet" "subnet" {
  for_each = var.subnet.subnets
  filter {
    name   = "subnet-id"
    values = [each.value.id]
  }
}

resource "aws_instance" "ec2_instance" {
  for_each                  = var.ec2
  ami                       = local.ami[each.value.ami_id].id
  instance_type             = each.value.instance_type
  key_name                  = each.value.key_name
  subnet_id                 = var.subnet.subnets[each.value.subnet].id
  vpc_security_group_ids    = [for sg in each.value.security_groups: var.sgs.sgs[sg]]
  associate_public_ip_address = each.value.associate_public_ip_address
  root_block_device {
    volume_size             = each.value.disk_size
  }
  tags = {
    Name = "${each.value.tag_name}-${each.key}"
  }
}

locals {
  mapping_sg_to_ec2 = {
    for k, v in var.ec2 : k => [for sg in var.ec2[k].security_groups: lookup(var.sgs.sgs, sg, null) if sg != null]
  }
}

output "sg_test" {
  value = local.mapping_sg_to_ec2
}

output "amis" {
  value = local.ami
}

output "ec2_instances" {
  value = aws_instance.ec2_instance
}
