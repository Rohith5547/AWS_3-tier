variable instance_type {
    type = string
    description = "instance type of ec2 machine"
}

variable "web_subnet_ids" {
  type        = list(string)
  description = "Private subnets for ASG"
}




