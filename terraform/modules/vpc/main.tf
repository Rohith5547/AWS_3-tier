resource "aws_vpc" "management" {
  cidr_block       = var.management_cidr_block
  instance_tenancy = "default"

  tags = merge (
    {
        Name = "${var.name}-management-vpc"
        Environment = var.environment
    },
    var.tags
  )
}
resource "aws_vpc" "application" {
  cidr_block       = var.application_cidr_block

  tags = merge (
    {
        Name = "${var.name}-application-vpc"
        Environment = var.environment
    },
    var.tags
  )
}


