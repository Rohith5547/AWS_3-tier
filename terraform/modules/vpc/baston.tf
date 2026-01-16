resource "aws_instance" "baston" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.management_public_subnet.id
  vpc_security_group_ids = ../se


  tags = {
    Name = "baston-host"
  }
}


