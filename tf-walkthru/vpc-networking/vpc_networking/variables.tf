variable "region" {
  default = "us-west-2"
}

variable "periscopai_vpc_cidr_block" {}
variable "public_subnet_A_cidr_block" {}
variable "public_subnet_B_cidr_block" {}
variable "public_subnet_C_cidr_block" {}
variable "private_subnet_A_cidr_block" {}
variable "private_subnet_B_cidr_block" {}
variable "private_subnet_C_cidr_block" {}
variable "eip_association_address" {}
variable "ec2_keypair" {}
variable "ec2_instance_type" {}