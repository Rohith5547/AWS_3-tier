output "management_vpc_id" {
  value = aws_vpc.management.id
}

output "cidr_block" {
  value = aws_vpc.management.cidr_block
}

output "transit_gateway" {
  value = aws_ec2_transit_gateway.tgw.id
}

output "management_subnet_cidr_block" {
  value = aws_subnet.management_public_subnet.id
}