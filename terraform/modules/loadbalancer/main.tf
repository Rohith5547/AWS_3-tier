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

resource "aws_lb_target_group" "web_instances" {
  name     = "${var.environment}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.application_vpc_id
  target_type = "ip"
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
  health_check {
    enabled             = true
    interval            = 30
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-299"
  } 
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.internet_facing.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "" #Need to replace with account certificate

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_instances.arn
  }
}
