resource "aws_key_pair" "sshkey" {
  key_name   = "loginKey"
  public_key = file("~/.ssh/id_ed25519.pub")
}

module "network" {
  source = "../../modules/vpc"

  environment                   = var.environment
  management_cidr_block         = var.management_cidr_block
  management_public_subnet_cidr = var.management_public_subnet_cidr
  management_public_az          = var.management_public_az

}
module "bastion" {
  source = "../../modules/bastion"

  subnet_id     = module.network.public_subnet_ids[0]
  bastion_sg_id = module.security.bastion_sg_id
  key_name      = aws_key_pair.sshkey.key_name
  ami = var.ami
  instance_type = var.instance_type
  environment = var.environment
}

module "security" {
  source = "../../modules/security"

  management_vpc_id = module.network.management_vpc_id 

}

