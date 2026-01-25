resource "aws_lb" "internet_facing" {
  name               = "${var.environment}-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]

  subnets     = var.public_subnet_ids

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
  target_type = "instance"
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
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.ACM_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_instances.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.internet_facing.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb" "internal_lb" {
  name               = "${var.environment}-app-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_app_lb_sg.id] 
  subnets            = var.internal_lb_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "app_instances" {
  name     = "${var.environment}-app-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.application_vpc_id
  target_type = "instance"
  deregistration_delay = 60
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
  load_balancer_arn = aws_lb.internal_lb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_instances.arn
  }
}
