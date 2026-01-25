resource "aws_ec2_transit_gateway" "tgw" {
  description                     = "Dev Central Transit Gateway"
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "${var.environment}-centra-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  vpc_id             = aws_vpc.vpc.id
  subnet_ids         = values(aws_subnet.tgw_subnets)[*].id
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  dns_support  = "enable"
  ipv6_support = "disable"

  tags = {
    Name = "${var.environment}-tgw-attachment"
  }
}
