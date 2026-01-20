# VPC ID and CIDR
variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-07186e577929d71eb" # replace with your VPC ID
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/22" # replace with your VPC CIDR
}

# Subnets
variable "public_subnet_id" {
  description = "Public subnet ID"
  default     = "subnet-0235eb366e48629a1" # public subnet
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  default     = "subnet-0cd2b8113ee23dc78" # private subnet
}
