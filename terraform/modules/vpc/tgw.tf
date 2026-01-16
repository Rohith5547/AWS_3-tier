resource "aws_ec2_transit_gateway" "tgw" {
  description                     = "Central Transit Gateway"
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "central-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  vpc_id             = aws_vpc.management.id
  subnet_ids         = [aws_subnet.management_public_subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  dns_support  = "enable"
  ipv6_support = "disable"

  tags = {
    Name = "central"
  }
}

# resource "aws_route" "to_tgw" {
#   for_each = toset(var.tgw_destination_cidrs)

#   route_table_id         = aws_route_table.public.id
#   destination_cidr_block = each.value
#   transit_gateway_id     = var.tgw_id

#   depends_on = [aws_ec2_transit_gateway_vpc_attachment.this]
# }