resource "aws_lb_target_group" "web_instances" {
  depends_on = [ aws_lb.internet_facing ]
  name     = "web-asg"
  port     = 443
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
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
  certificate_arn   = var.ACM_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_instances.arn
  }
}
