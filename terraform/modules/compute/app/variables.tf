variable instance_type {
    type = string
    description = "instance type of ec2 machine"
}

variable "app_subnet_ids" {
  type        = list(string)
  description = "Private subnets for ASG"
}

variable "instance_profile_name" {
    type = string
}
