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
