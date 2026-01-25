variable instance_type {
    type = string
    description = "instance type of ec2 machine"
}

variable "web_subnet_ids" {
  type        = list(string)
  description = "Private subnets for ASG"
}

variable "internal_lb_dns" {
    type = string
    description = "dns of load balancer"
}

variable "environment" {
    type = string
    description = "dev, qa or prod"
}

variable "instance_profile_name" {
    type = string
}


