resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-sg-"
  vpc_id = var.application_vpc_id
  description = "Allow SSH inbound traffic"

  # Ingress (inbound) rule for port 80 (http)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Ingress (inbound) rule for port 443 (https)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Egress (outbound) rule: allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}