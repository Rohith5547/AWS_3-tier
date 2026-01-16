module "network" {
  source = "../../modules/vpc"

  environment                   = var.environment
  management_cidr_block         = var.management_cidr_block
  management_public_subnet_cidr = var.management_public_subnet_cidr
  management_public_az          = var.management_public_az

}


