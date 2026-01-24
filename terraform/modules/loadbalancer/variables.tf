variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"
}

variable "application_vpc_id" {
  type = string
  description = "Vpc id of application vpc"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for internet-facing ALB"
}

variable "internal_lb_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for internal ALB"
}

variable "ACM_certificate" {
  type = string
  description = "certificate for verification"
}