variable "management_cidr_block" {
  type        = string
  description = "CIDR block for the management VPC"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"

  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "Environment must be one of dev, qa, or prod."
  }
}

variable "management_public_subnet_cidr" {
  type = string
}

variable "management_public_az" {
  type = string
}
