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
}

variable "management_public_az" {
  type = string
}

variable "region" {
  type = string
}

