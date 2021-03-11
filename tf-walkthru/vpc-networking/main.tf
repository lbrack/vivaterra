module "vpc_networking" {
  source = "..\/vpc_networking"
  periscopai_vpc_cidr_block = var.periscopai_vpc_cidr_block
  public_subnet_A_cidr_block = var.public_subnet_A_cidr_block
  public_subnet_B_cidr_block = var.public_subnet_B_cidr_block
  public_subnet_C_cidr_block = var.public_subnet_C_cidr_block
  private_subnet_A_cidr_block = var.private_subnet_A_cidr_block
  private_subnet_B_cidr_block = var.private_subnet_B_cidr_block
  private_subnet_C_cidr_block = var.private_subnet_C_cidr_block
  eip_association_address = var.eip_association_address
  ec2_instance_type = var.ec2_instance_type
  ec2_keypair = var.ec2_keypair
}