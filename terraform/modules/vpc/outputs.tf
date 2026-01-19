output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.tgw.id
}
