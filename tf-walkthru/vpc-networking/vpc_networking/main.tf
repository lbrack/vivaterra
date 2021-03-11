provider "aws" {
  region = var.region
}

resource "aws_vpc" "periscopai_vpc" {
  cidr_block = var.periscopai_vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name="Periscopai-Stage-VPC"
  }
}

resource "aws_subnet" "module_public_subnet_A" {
  cidr_block = var.public_subnet_A_cidr_block
  vpc_id = aws_vpc.module_vpc.id
  availability_zone = "${var.region}a"

  tags = {
    Name="Public-Subnet-A"
  }
}

resource "aws_subnet" "module_public_subnet_B" {
  cidr_block = var.public_subnet_B_cidr_block
  vpc_id = aws_vpc.module_vpc.id
  availability_zone = "${var.region}b"

  tags = {
    Name="Public-Subnet-B"
  }
}

resource "aws_subnet" "module_public_subnet_C" {
  cidr_block = var.public_subnet_C_cidr_block
  vpc_id = aws_vpc.module_vpc.id
  availability_zone = "${var.region}c"

  tags = {
    Name="Public-Subnet-C"
  }
}

resource "aws_subnet" "module_private_subnet_A" {
  cidr_block = var.private_subnet_A_cidr_block
  vpc_id = aws_vpc.module_vpc.id
  availability_zone = "${var.region}a"

  tags = {
    Name="Private-Subnet-1"
  }
}

resource "aws_subnet" "module_private_subnet_B" {
  cidr_block = var.private_subnet_B_cidr_block
  vpc_id = aws_vpc.module_vpc.id
  availability_zone = "${var.region}b"

  tags = {
    Name="Private-Subnet-2"
  }
}

resource "aws_subnet" "module_private_subnet_C" {
  cidr_block = var.private_subnet_C_cidr_block
  vpc_id = aws_vpc.module_vpc.id
  availability_zone = "${var.region}c"

  tags = {
    Name="Private-Subnet-3"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name="Public-Route-Table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name="Private-Route-Table"
  }
}
//------------------------------------------------------------------------
// Associates a route table to a give subnet
// Public route table to public subnet and private route table to private

resource "aws_route_table_association" "public_subnet_A_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_A.id
}

resource "aws_route_table_association" "public_subnet_B_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_B.id
}

resource "aws_route_table_association" "public_subnet_C_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_C.id
}

resource "aws_route_table_association" "private_subnet_A_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet_A.id
}

resource "aws_route_table_association" "private_subnet_B_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet_B.id
}

resource "aws_route_table_association" "private_subnet_C_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet_C.id
}

//------------------------------------------------------------------------

resource "aws_eip" "elastic_ip_for_nat_gw" {
  vpc = true
  associate_with_private_ip = var.eip_association_address

  tags = {
    Name="Stage-EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip_for_nat_gw.id
  subnet_id = aws_subnet.module_public_subnet_A.id

  tags = {
    Name="Stage-NAT-GW"
  }
}

resource "aws_route" "nat_gateway_route" {
  route_table_id = aws_route_table.private_route_table.id
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.module_vpc.id

  tags = {
    Name="Stage-IGW"
  }
}

resource "aws_route" "igw_route" {
  route_table_id = aws_route_table.public_route_table.id
  gateway_id = aws_internet_gateway.internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

data "aws_ami" "ubuntu_latest" {
  owners = ["099720109477"]
  most_recent = true

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "my-first-ec2-instance" {
  ami = data.aws_ami.ubuntu_latest.id
  instance_type = var.ec2_instance_type
  key_name = var.ec2_keypair
  security_groups = [aws_security_group.ec2-security-group.id]
  subnet_id = aws_subnet.module_public_subnet_A.id
}

resource "aws_security_group" "ec2-security-group" {
  name = "EC2-Instance-SG"
  vpc_id = aws_vpc.module_vpc.id

  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}








