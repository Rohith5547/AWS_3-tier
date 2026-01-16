resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH to Bastion"
  vpc_id      = ../vpc/aws_vpc.management.id

  ingress {
    description = "SSH from allowed sources"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # replace with your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}
