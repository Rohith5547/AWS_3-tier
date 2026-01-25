resource "aws_security_group" "db_sg" {
  name_prefix = "db-sg-"
  vpc_id = var.application_vpc_id
  description = "Accept traffic from app tier"

  # Ingress (inbound) rule for port 3306 (tcp)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}