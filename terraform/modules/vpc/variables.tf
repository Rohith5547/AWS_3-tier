variable "management_cidr_block" {
  type        = string
  description = "CIDR block for the management VPC"
}

variable "application_cidr_block" {
  type        = string
  description = "CIDR block for the app VPC"
}

variable "name" {
  type        = string
  description = "VPC name"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "management_public_subnet_cidr" {
  type = string
}

variable "management_public_az" {
  type = string
}

variable "tgw_id" {
  type = string
}

variable "tgw_destination_cidrs" {
  type = list(string)
}