resource "aws_vpc" "management" {
  cidr_block       = var.management_cidr_block
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-management-vpc"
  }
}