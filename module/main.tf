provider "aws" {
  region = "us-west-2"
}

module "vpc_module" {
  source = "./modules/vpc_networking"
  // We are passing the variables as parameter to the sub-module.
  // Those are defined in variables.tf
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}