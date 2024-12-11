resource "aws_route_table" "route_table" {
  for_each = var.routes
  vpc_id   = var.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.gateways.igws[each.value.target_gateway].id
  }
}

resource "aws_route_table_association" "rt_subnets" {
  for_each       = var.routes
  subnet_id      = var.subnets.subnets[each.value.destination_network].id
  route_table_id = aws_route_table.route_table[each.key].id
}

output "routes" { value = aws_route_table.route_table }

output "association_rt" {
  value = aws_route_table_association.rt_subnets
}
