variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"
  default = "dev"
}

variable "management_cidr_block" {
  type        = string
  description = "CIDR block for the management VPC"
  default = "10.0.0.0/16"
}



variable "management_public_subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "management_public_az" {
  type = string
  default = "us-east-1a"
}

variable "region" {
  type = string
}

