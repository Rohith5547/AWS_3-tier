# Create an Internet Gateway
resource "aws_internet_gateway" "management" {
  vpc_id = aws_vpc.management.id


  tags = {
    Name = "management-igw"
  }
}

resource "aws_internet_gateway_attachment" "management" {
  internet_gateway_id = aws_internet_gateway.management.id
  vpc_id              = aws_vpc.management.id
}