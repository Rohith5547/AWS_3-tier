resource "aws_security_group" "internal_app_lb_sg" {
  name_prefix = "internal_app_lb-sg-"
  vpc_id = var.application_vpc_id
  description = "Accept traffic from Web ec2 and transfer to app ec2"

  # Ingress (inbound) rule for port 80 (http)
  ingress {
    from_port   = 8080    
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }
  


  # Egress (outbound) rule: allow all outbound traffic
  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}