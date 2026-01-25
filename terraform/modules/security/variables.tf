variable "management_vpc_id" {
    type = string
}

variable "application_vpc_id" {
    type = string
}

variable "admin_cidr" {
  type        = string
  description = "Admin public IP CIDR for SSH"
}
