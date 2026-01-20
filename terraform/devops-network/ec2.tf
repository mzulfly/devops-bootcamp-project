# ---------------------- Latest Ubuntu AMI ----------------------
data "aws_ssm_parameter" "ubuntu_latest" {
  name = "/aws/service/canonical/ubuntu/server/noble/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

# ---------------------- EC2 Instances ----------------------
# Web server → public subnet with static private IP
resource "aws_instance" "web_server" {
  ami                         = data.aws_ssm_parameter.ubuntu_latest.value
  instance_type               = "t3.micro"
  associate_public_ip_address = false  # EIP will provide public IP
  private_ip                  = "10.0.0.5"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  tags = { Name = "web-server" }
}

# Elastic IP for Web server
resource "aws_eip" "web_eip" {
  instance = aws_instance.web_server.id
  tags = { Name = "web-eip" }
}

# Ansible controller → private subnet
resource "aws_instance" "ansible_controller" {
  ami                         = data.aws_ssm_parameter.ubuntu_latest.value
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  private_ip                  = "10.0.0.135"
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  tags = { Name = "ansible-controller" }
}

# Monitoring server → private subnet
resource "aws_instance" "monitoring_server" {
  ami                         = data.aws_ssm_parameter.ubuntu_latest.value
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  private_ip                  = "10.0.0.136"
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  tags = { Name = "monitoring-server" }
}