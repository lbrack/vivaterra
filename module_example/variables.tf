variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "VPC cidr block"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
  description = "public subnet CIDR"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
  description = "private subnet CIDR"
}