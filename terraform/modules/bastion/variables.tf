variable "subnet_id" {
  description = "Public subnet ID for bastion"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group ID for bastion"
  type        = string
}


variable "instance_type" {
    type = string
}

variable "ami" {
    type = string
}

variable "key_name" {
    type = string
}

variable "environment" {
    type = string
}