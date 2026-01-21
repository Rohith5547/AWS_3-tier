resource "aws_security_group" "db_sg" {
  name_prefix = "db-sg-"
  vpc_id = var.application_vpc_id
  description = "Accept traffic from ALB and transfer to internal ALB"

  # Ingress (inbound) rule for port 3306 (tcp)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
}