output "app_asg_name" {
  description = "Name of the app Auto Scaling Group"
  value       = aws_autoscaling_group.app-asg.name
}

output "app_asg_arn" {
  description = "ARN of the app Auto Scaling Group"
  value       = aws_autoscaling_group.app-asg.arn
}

output "app_launch_template_id" {
  description = "Launch Template ID used by app ASG"
  value       = aws_launch_template.app.id
}
output "app_launch_template_latest_version" {
  description = "Latest version of app Launch Template"
  value       = aws_launch_template.app.latest_version
}
output "app_target_group_arns" {
  description = "Target group ARNs attached to the app ASG"
  value       = aws_autoscaling_group.app-asg.target_group_arns
}
output "app_ami_id" {
  description = "AMI ID used for App instances"
  value       = data.aws_ami.ubuntu.id
}

output "app_security_group_id" {
  description = "Security group ID for App instances"
  value       = aws_security_group.app_sg.id
}



