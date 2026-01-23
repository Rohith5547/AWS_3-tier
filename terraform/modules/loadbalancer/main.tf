resource "aws_lb" "internet_facing" {
  name               = "web-access-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]

  subnets     = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb" "internal_lb" {
  name               = "app-access-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_app_lb_sg.id] 
  subnets            = var.internal_lb_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}