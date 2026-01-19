resource "aws_key_pair" "sshkey" {
  key_name   = "loginKey"
  public_key = file("~/.ssh/id_ed25519.pub")
}

module "management" {
  source = "../../modules/vpc"



  environment     = var.environment
  vpc_cidr        = var.management.vpc_cidr
  
  public_subnets  = var.management.public_subnets

}

module "application_web" {
  source = "../../modules/vpc"

  vpc_cidr        = var.application.vpc_cidr
  environment     = var.environment
  public_subnets  = var.application_web_tier.public_subnets
  web_subnets = var.application_web_tier.private_subnets

}
module "application_app" {
  source = "../../modules/vpc"

  vpc_cidr        = var.application.vpc_cidr
  environment     = var.environment
  public_subnets  = var.application_app_tier.public_subnets
  app_subnets = var.application_app_tier.private_subnets

}
module "application_database" {
  source = "../../modules/vpc"

  vpc_cidr        = var.application.vpc_cidr
  environment     = var.environment
  db_subnets = var.application_database_tier.private_subnets

}
module "bastion" {
  source = "../../modules/bastion"

  subnet_id     = module.management.public_subnet_ids[0]
  bastion_sg_id = module.security.bastion_sg_id
  key_name      = aws_key_pair.sshkey.key_name
  ami = var.ami
  instance_type = var.instance_type
  environment = var.environment
}

module "security" {
  source = "../../modules/security"

  management_vpc_id = module.management.vpc_id 

}

