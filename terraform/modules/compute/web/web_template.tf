data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical (official Ubuntu publisher)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "web" {
  name_prefix = "web-application-"
  
  ebs_optimized = true

  image_id = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  metadata_options {
    http_tokens                 = "required"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web-instance"
    }
  }

  user_data = filebase64("${path.module}/web_userdata.sh")
}

resource "aws_autoscaling_group" "web-asg" {
  vpc_zone_identifier = var.web_subnet_ids
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  tag {
    key                 = "Key"
    value               = "Value"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  target_group_arns = [aws_lb_target_group.web_instances.arn]
}

