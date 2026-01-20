resource "aws_lb" "test" {
  name               = "web-access-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]

  enable_deletion_protection = true

  tags = {
    Environment = var.environment
  }
}