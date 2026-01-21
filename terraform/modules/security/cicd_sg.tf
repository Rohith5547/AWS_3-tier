resource "aws_security_group" "cicd_sg" {
  name_prefix = "cicd-sg-"
  vpc_id = var.application_vpc_id
  description = "Accept traffic from bastion"

  # Ingress (inbound) rule for port 80 (http)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastionSg.id]
    # OR cidr_blocks = ["YOUR_IP/32"]
  }


  # Egress (outbound) rule: allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}