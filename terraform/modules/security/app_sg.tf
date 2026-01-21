resource "aws_security_group" "app_sg" {
  name_prefix = "app-sg-"
  vpc_id = var.application_vpc_id
  description = "Accept traffic from internal ALB and transfer to database RDS"

  # Ingress (inbound) rule for port 80 (http)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.internal_app_lb_sg.id]
  }


  # Egress (outbound) rule: allow all outbound traffic
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.db_sg.id]
  }
}