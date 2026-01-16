output "vpc_id" {
  value = aws_vpc.management.id
}

output "cidr_block" {
  value = aws_vpc.management.cidr_block
}
