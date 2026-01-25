variable instance_type {
    type = string
    description = "instance type of ec2 machine"
}

variable "db_subnet_ids" {
  type        = list(string)
  description = "Private subnets for ASG"
}

variable "instance_profile_name" {
    type = string
}

variable "environment" {
    type = string
    description = "envs dev|qa|prod"
}

variable "db_sg" {
    type = string
    description = "security group of database"
}