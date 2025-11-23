locals {
  common_tags = {
    ManagedBy   = "Terraform"
    Project     = "Terraform-Ansible-Stack"
    Environment = "Development"
    Author      = "Aman"
  }
}

resource "aws_vpc" "Main_VPC" {
  cidr_block = var.Main_VPC-cidr_block
  tags = merge(local.common_tags, {
    Name = var.Main_VPC
  })
}

resource "aws_subnet" "Public_Subnet" {
  vpc_id                  = aws_vpc.Main_VPC.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
  tags = merge(local.common_tags, {
    Name = var.public_subnet
  })
}

resource "aws_internet_gateway" "Main_IGW" {
  vpc_id = aws_vpc.Main_VPC.id
  tags = merge(local.common_tags, {
    Name = var.main_IGW
  })
}

resource "aws_route_table" "public_RTB" {
  vpc_id = aws_vpc.Main_VPC.id
  route {
    gateway_id = aws_internet_gateway.Main_IGW.id
    cidr_block = "0.0.0.0/0"
  }
  tags = merge(local.common_tags, {
    Name = var.public_RTB
  })
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.Public_Subnet.id
  route_table_id = aws_route_table.public_RTB.id
}

output "vpc_name" {
  value = aws_vpc.Main_VPC[*].tags_all
}