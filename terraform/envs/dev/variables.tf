variable "environment" {
  type        = string
  description = "Environment name (dev, qa, prod)"
}

variable "management" {
  type = object({
    vpc_cidr         = string
    public_subnets   = map(string)
  })
}
variable "application" {
  type = object({
    vpc_cidr = string

    public_subnets = map(string)
    web_subnets    = map(string)
    app_subnets    = map(string)
    db_subnets     = map(string)
    cicd_subnets   = map(string)
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
