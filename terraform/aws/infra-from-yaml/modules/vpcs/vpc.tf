# If VPS's id doesn't defined, then create a new VPC. Otherwise, use the existing VPC in the data block.
resource "aws_vpc" "vpc" {
  count = var.id == null ? 1 : 0
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.tags_name}"
  }
}

# If VPS's id is defined, then use the existing VPC in the data block.
data "aws_vpc" "existing" {
  count = var.id != null ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [var.id]
  }
}

# If VPS's id doesn't defined, then output the new VPC. Otherwise, output the existing VPC.
output "vpcs" {
  value = var.id != null ? data.aws_vpc.existing[0] : aws_vpc.vpc[0]
}
