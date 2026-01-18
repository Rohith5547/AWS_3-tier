variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"
}

variable "management_cidr_block" {
  type        = string
  description = "CIDR block for the management VPC"
  
}

variable "management_public_subnet_cidr" {
  type = string
  description = "CIDR block for the management public subnet"
}

variable "management_public_az" {
  type = string
  description = "Availability Zone for the management public subnet"
}

variable "region" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}
