resource "aws_subnet" "management_public_subnet" {
  vpc_id            = aws_vpc.management.id
  cidr_block        = var.management_public_subnet_cidr
  # Assign public IP addresses automatically to instances launched in this subnet
  map_public_ip_on_launch = true 
  # Choose an Availability Zone
  availability_zone = var.management_public_az

  tags = {
    Name = "${var.environment}-management-public-subnet"
  }
}

resource "aws_route_table" "management_public" {
  vpc_id = aws_vpc.management.id

  tags = {
    Name = "management-public-rt"
  }
}

# 5. Add a route to the Internet Gateway in the public route table
resource "aws_route" "public_internet_gateway_route" {
  route_table_id         = aws_route_table.management_public.id
  destination_cidr_block = "0.0.0.0/0" # Destination for all internet traffic
  gateway_id             = aws_internet_gateway.management.id
}

# 6. Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.management_public_subnet.id
  route_table_id = aws_route_table.management_public.id
}


