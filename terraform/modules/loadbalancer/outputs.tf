output "alb_id" {
    value = aws_lb.test.id
}

output "alb_arn" {
  value = aws_lb.internet_facing.arn
}

output "alb_dns_name" {
  value = aws_lb.internet_facing.dns_name
}

output "web_target_group_arn" {
  value = aws_lb_target_group.web_instances.arn
}

