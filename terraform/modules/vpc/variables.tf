variable "vpc_cidr" {
  type        = string
  description = "CIDR block"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"

  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "Environment must be one of dev, qa, or prod."
  }
}

variable "public_subnets" {
  type = map(string)
  description = "mapping Az to cidr block"
  default = ""
}

variable "private_subnets" {
  type = map(string)
  description = "mapping Az to cidr block"
  default = ""
}

