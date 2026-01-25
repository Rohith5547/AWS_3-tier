output "web_asg_name" {
  description = "Name of the Web Auto Scaling Group"
  value       = aws_autoscaling_group.web-asg.name
}

output "web_asg_arn" {
  description = "ARN of the Web Auto Scaling Group"
  value       = aws_autoscaling_group.web-asg.arn
}

output "web_launch_template_id" {
  description = "Launch Template ID used by Web ASG"
  value       = aws_launch_template.web.id
}
output "web_launch_template_latest_version" {
  description = "Latest version of Web Launch Template"
  value       = aws_launch_template.web.latest_version
}
output "web_target_group_arns" {
  description = "Target group ARNs attached to the Web ASG"
  value       = aws_autoscaling_group.web-asg.target_group_arns
}
output "web_ami_id" {
  description = "AMI ID used for Web instances"
  value       = data.aws_ami.ubuntu.id
}

output "web_security_group_id" {
  description = "Security group ID for Web instances"
  value       = aws_security_group.web_sg.id
}



