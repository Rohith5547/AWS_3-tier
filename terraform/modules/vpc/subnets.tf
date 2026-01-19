resource "aws_subnet" "public_subnets" {
  for_each          = var.public_subnets
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value

  # Assign public IP addresses automatically to instances launched in this subnet
  map_public_ip_on_launch = true 
  # Choose an Availability Zone
  availability_zone = each.key

  tags = {
    Name = "${var.environment}-public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value

  # Choose an Availability Zone
  availability_zone = each.key

  # Assign public IP addresses automatically to instances launched in this subnet
  map_public_ip_on_launch = true 

  tags = {
    Name = "${var.environment}-private-subnet-${each.key}"
  }
}

resource "aws_route_table" "management_public" {
  vpc_id = aws_vpc.management.id

  tags = {
    Name = "${var.environment}-management-public-rt"
    Environment = var.environment
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "management" {
  vpc_id = aws_vpc.management.id
  tags = {
    Name = "${var.environment}-management-igw"
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


