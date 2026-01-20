# ------------------------------
# Variables
# ------------------------------
variable "public_subnet_id" {}
variable "private_subnet_id" {}

# ------------------------------
# Elastic IP for Web Server
# ------------------------------
# Create Elastic IP
resource "aws_eip" "web_eip" {
  # No 'vpc' attribute needed anymore
}

# Associate it to Web Server
resource "aws_eip_association" "web_eip_assoc" {
  instance_id   = aws_instance.web_server.id
  allocation_id = aws_eip.web_eip.id
}

# ------------------------------
# Web Server (Public)
# ------------------------------
resource "aws_instance" "web_server" {
  ami                    = "ami-0abcdef1234567890"  # Ubuntu 24.04 AMI ID, update with real one for your region
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_id
  private_ip             = "10.0.0.5"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  associate_public_ip_address = true  # needed to attach Elastic IP

  tags = {
    Name = "WebServer"
  }
}

# ------------------------------
# Ansible Controller (Private)
# ------------------------------
resource "aws_instance" "ansible_controller" {
  ami                    = "ami-0abcdef1234567890"  # Ubuntu 24.04 AMI
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_id
  private_ip             = "10.0.0.135"
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  associate_public_ip_address = false  # Private only

  tags = {
    Name = "AnsibleController"
  }
}

# ------------------------------
# Monitoring Server (Private)
# ------------------------------
resource "aws_instance" "monitoring_server" {
  ami                    = "ami-0abcdef1234567890"  # Ubuntu 24.04 AMI
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_id
  private_ip             = "10.0.0.136"
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  associate_public_ip_address = false  # Private only

  tags = {
    Name = "MonitoringServer"
  }
}
