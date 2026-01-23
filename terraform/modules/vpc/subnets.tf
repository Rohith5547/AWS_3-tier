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

resource "aws_subnet" "internal_lb" {
  for_each          = var.internal_lb_subnets
  
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

#NAT setting up
resource "aws_eip" "nat" {
  domain = "vpc"
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public_subnets)[0].id

  tags = {
    Name = "${var.environment}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-nat-rt"
  }
}
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.nat.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "nat_subnets" {
  for_each = merge(
    aws_subnet.app,
    aws_subnet.ci_cd,
    aws_subnet.web
  )

  subnet_id      = each.value.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table" "isolated" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-isolated-rt"
  }
}

resource "aws_route_table_association" "isolated_subnets" {
  for_each = merge(
    aws_subnet.db,
    aws_subnet.internal_lb
  )

  subnet_id      = each.value.id
  route_table_id = aws_route_table.isolated.id
}
