// 16 bit for entire VPC
variable "vpc_cidr_block" {
  description = "VPC cidr block"
}

variable "public_subnet_cidr" {
  description = "public subnet CIDR"
}

variable "private_subnet_cidr" {
  description = "private subnet CIDR"
}