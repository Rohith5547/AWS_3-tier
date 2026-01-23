output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.tgw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public_subnets : s.id]
}

output "web_subnet_ids" {
  value = [for s in aws_subnet.web : s.id]
}

output "app_subnet_ids" {
  value = [for s in aws_subnet.app : s.id]
}

output "internal_lb_subnet_ids" {
  value = [for s in aws_subnet.internal_lb : s.id]
}

output "cicd_subnet_ids" {
  value = [for s in aws_subnet.ci_cd : s.id]
}

output "db_subnet_ids" {
  value = [for s in aws_subnet.db : s.id]
}

