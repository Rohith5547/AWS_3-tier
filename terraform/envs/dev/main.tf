resource "aws_key_pair" "sshkey" {
  key_name   = "loginKey-${var.environment}"
  public_key = file("~/.ssh/id_ed25519.pub")
}

module "management" {
  source = "../../modules/vpc"



  environment     = var.environment
  vpc_cidr        = var.management.vpc_cidr
  
  public_subnets  = var.management.public_subnets

}

module "application" {
  source = "../../modules/vpc"

  vpc_cidr        = var.application.vpc_cidr
  environment     = var.environment
  web_subnets = var.application.web_subnets
  app_subnets = var.application.app_subnets
  db_subnets = var.application.db_subnets
  cicd_subnets = var.application.cicd_subnets
  public_subnets = var.application.public_subnets

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

  application_vpc_id = module.management.vpc.id
  management_vpc_id = module.application.vpc.id

}

