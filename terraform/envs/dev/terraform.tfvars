environment                   = "dev"

#management vpc
management = {
  vpc_cidr = "10.0.0.0/16"

  public_subnets = {
    us-east-1a = "10.0.1.0/24"
  }

  private_subnets = {}
}

#application vpc
application_web_tier = {
  vpc_cidr = "10.10.0.0/16"

  public_subnets = {
    us-east-1a = "10.10.1.0/24"
  }

  private_subnets = {
    us-east-1a = "10.10.11.0/24"
    us-east-1b = "10.10.12.0/24"
  }
}

application_app_tier = {
  vpc_cidr = "10.10.0.0/16"

  public_subnets = {
    us-east-1a = "10.10.2.0/24"
  }

  private_subnets = {
    us-east-1a = "10.10.13.0/24"
    us-east-1b = "10.10.14.0/24"
  }
}

application_database_tier = {
  vpc_cidr = "10.10.0.0/16"

  public_subnets = {}

  private_subnets = {
    us-east-1a = "10.10.15.0/24"
    us-east-1b = "10.10.16.0/24"
  }
}



region                        = "us-east-1"

ami           = ""  #replace ubuntu ami later
instance_type = "t3.micro"


