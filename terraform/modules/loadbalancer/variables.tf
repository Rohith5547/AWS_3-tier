variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for internet-facing ALB"
}

variable "internal_lb_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for internal ALB"
}
