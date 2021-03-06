provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "module_vpc" {
  cidr_block = var.vpc_cidr_block // defined in the variables.tf
  tags = {
    Name = "Fakayu"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet_cidr
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name = "Fakayu2"
  }

}

resource "aws_subnet" "private_subnet" {
  cidr_block = var.private_subnet_cidr
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name = "Fakame?"
  }

}