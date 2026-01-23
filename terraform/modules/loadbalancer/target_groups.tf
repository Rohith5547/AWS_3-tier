resource "aws_lb_target_group" "web_instances" {
  name     = "web-asg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  target_type = "ip"
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.internet_facing.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_instances.arn
  }
}
