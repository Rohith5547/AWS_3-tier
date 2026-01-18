resource "aws_security_group" "bastionSg" {
  name_prefix = "ssh-access-sg-"
  vpc_id = var.management_vpc_id
  description = "Allow SSH inbound traffic"

  # Ingress (inbound) rule for port 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Allow access from any IP (0.0.0.0/0). Restrict this to your specific IP for better security.
    cidr_blocks = [""]  #replace with devOps engineer laptop IP
  }

  # Egress (outbound) rule: allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}