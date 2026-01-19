variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"
}

variable "management" {
  type = object({
    vpc_cidr         = string
    public_subnets   = map(string)
    private_subnets  = map(string)
  })
}
variable "application_web_tier" {
  type = object({
    vpc_cidr         = string
    public_subnets   = map(string)
    private_subnets  = map(string)
  })
}

variable "application_app_tier" {
  type = object({
    vpc_cidr         = string
    public_subnets   = map(string)
    private_subnets  = map(string)
  })
}

variable "application_database_tier" {
  type = object({
    vpc_cidr         = string
    public_subnets   = map(string)
    private_subnets  = map(string)
  })
}




variable "region" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}
