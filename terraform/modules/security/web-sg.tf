resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"
  vpc_id = var.application_vpc_id
  description = "Accept traffic from ALB and transfer to internal ALB"

  # Ingress (inbound) rule for port 80 (http)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }


  # Egress (outbound) rule: allow all outbound traffic
  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "-1"
    security_groups = [aws_security_group.internal_app_lb_sg.id]
  }
}