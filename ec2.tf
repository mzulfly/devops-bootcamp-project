data "aws_ssm_parameter" "ubuntu_latest" {
  name = "/aws/service/canonical/ubuntu/server/noble/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

# Web server → public subnet
resource "aws_instance" "web_server" {
  ami                         = data.aws_ssm_parameter.ubuntu_latest.value # replace with your custom web AMI
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  tags = { Name = "web-server" }
}

# Ansible controller → private subnet
resource "aws_instance" "ansible_controller" {
  ami                         = data.aws_ssm_parameter.ubuntu_latest.value # replace with custom AMI
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  tags = { Name = "ansible-controller" }
}

# Monitoring server → private subnet
resource "aws_instance" "monitoring_server" {
  ami                         = data.aws_ssm_parameter.ubuntu_latest.value # replace with custom AMI
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  tags = { Name = "monitoring-server" }
}

