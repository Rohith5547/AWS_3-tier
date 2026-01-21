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

resource "aws_launch_template" "cicd" {
  name_prefix = "cicd-"
  
  ebs_optimized = true

  image_id = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  metadata_options {
    http_tokens = "required"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
  }

  vpc_security_group_ids = [aws_security_group.cicd_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "cicd-instance"
    }
  }

  user_data = filebase64("${path.module}/cicd_userdata.sh")
}