provider "aws" {
  region = "ap-southeast-1"  # change as per your region
}

# Variables for VPC and subnet
variable "vpc_id" {}
variable "vpc_cidr_block" {} # e.g., "10.0.0.0/16"

# ------------------------------
# Web Server Security Group
# ------------------------------
resource "aws_security_group" "web_sg" {
  name        = "devops-public-sg"
  description = "Web Server Security Group"
  vpc_id      = var.vpc_id

  # Allow HTTP from anywhere
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH from VPC subnet only
  ingress {
    description = "Allow SSH from VPC subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------------
# Ansible & Monitoring Security Group
# ------------------------------
resource "aws_security_group" "private_sg" {
  name        = "devops-private-sg"
  description = "Ansible & Monitoring Security Group"
  vpc_id      = var.vpc_id

  # Allow SSH from VPC subnet only
  ingress {
    description = "Allow SSH from VPC subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
