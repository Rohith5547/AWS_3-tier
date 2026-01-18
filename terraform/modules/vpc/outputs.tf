output "management_vpc_id" {
  value = aws_vpc.management.id
}

output "management_cidr_block" {
  value = aws_vpc.management.cidr_block
}

output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.tgw.id
}

output "management_subnet_cidr_block" {
  value = aws_subnet.management_public_subnet.cidr_block
}


output "mananagement_public_subnet_ids" {
  description = "Public subnet IDs"
  value       = [aws_subnet.management_public_subnet[*].id]
}
