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
application = {
  vpc_cidr = "10.10.0.0/16"

  public_subnets = {
    us-east-1a = "10.10.1.0/24"
    us-east-1b = "10.10.2.0/24"
    
  }

  web_subnets = {
    us-east-1a = "10.10.11.0/24"
    us-east-1b = "10.10.12.0/24"
  }

  app_subnets = {
    us-east-1a = "10.10.13.0/24"
    us-east-1b = "10.10.14.0/24"
  }

  db_subnets = {
    us-east-1a = "10.10.15.0/24"
    us-east-1b = "10.10.16.0/24"
  }
  cicd_subnets = {
    us-east-1a = "10.10.17.0/24"
  }

}



region                        = "us-east-1"

ami           = ""  #replace ubuntu ami later
instance_type = "t3.micro"


