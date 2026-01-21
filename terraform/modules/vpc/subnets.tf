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

resource "aws_subnet" "web" {
  for_each          = var.web_subnets
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value

  # Choose an Availability Zone
  availability_zone = each.key

  tags = {
    Name = "${var.environment}-private-subnet-${each.key}"
  }
}

resource "aws_subnet" "app" {
  for_each          = var.app_subnets
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value

  # Choose an Availability Zone
  availability_zone = each.key

  tags = {
    Name = "${var.environment}-private-subnet-${each.key}"
  }
}

resource "aws_subnet" "db" {
  for_each          = var.db_subnets
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value

  # Choose an Availability Zone
  availability_zone = each.key
  tags = {
    Name = "${var.environment}-private-subnet-${each.key}"
  }
}
resource "aws_subnet" "ci_cd" {
  for_each          = var.cicd_subnets
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value

  # Choose an Availability Zone
  availability_zone = each.key
  tags = {
    Name = "${var.environment}-private-subnet-${each.key}"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-public-rt"
    Environment = var.environment
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment}-igw"
  }
}

#create NAT gateway in public subnet of application vpc
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.public_subnets.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


# 5. Add a route to the Internet Gateway in the public route table
resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.public.id  
  destination_cidr_block = "0.0.0.0/0" # Destination for all internet traffic
  gateway_id             = aws_internet_gateway.igw.id
}

# 6. Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}