# =========================
# Provider
# =========================
provider "aws" {
  region = "ap-southeast-1"
}

# =========================
# VPC
# =========================
resource "aws_vpc" "devops_vpc" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "devops-vpc"
  }
}

# =========================
# Subnets
# =========================
# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.0.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"
  tags = {
    Name = "devops-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.0.0.128/25"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "devops-private-subnet"
  }
}

# =========================
# Internet Gateway
# =========================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devops_vpc.id
  tags = {
    Name = "devops-igw"
  }
}

# =========================
# Elastic IP for NAT Gateway
# =========================
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "devops-nat-eip"
  }
}


# =========================
# NAT Gateway
# =========================
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "devops-ngw"
  }

  depends_on = [aws_internet_gateway.igw]
}

# =========================
# Route Tables
# =========================
# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.devops_vpc.id
  tags = {
    Name = "devops-public-route"
  }
}

# Public Route (to IGW)
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.devops_vpc.id
  tags = {
    Name = "devops-private-route"
  }
}

# Private Route (to NAT Gateway)
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
