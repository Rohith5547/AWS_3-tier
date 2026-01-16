module "management_vpc" {
  source    = "../../modules/vpc/main.tf"        
}

module "management_internet_gateway" {
  source = "../../modules/vpc/igw.tf"
}

module "management_public_subnet" {
  source = "../../modules/vpc/igw.tf"
}

