# DevOps Bootcamp Final Project
📌 Introduction

This repository contains the final graded capstone project for the DevOps Bootcamp.

The objective of this project is to design, provision, configure, deploy, monitor, and document a complete DevOps-based infrastructure using industry-standard tools and best practices.

Successful completion of this project is mandatory to:

* Pass the DevOps Bootcamp

* Receive the DevOps Bootcamp Certificate


# Project Objectives

By completing this project, the following DevOps competencies are demonstrated:

1. Provision AWS infrastructure using Infrastructure as Code (Terraform)

2. Apply Configuration Management using Ansible

3. Deploy a containerized web application

4. Implement monitoring using Prometheus and Grafana

5. Apply DevOps tools, automation, and best practices

6. Publish technical documentation using GitHub Pages


# Technology Stack

1. Cloud Provider: AWS (ap-southeast-1)

2. IaC: Terraform

3. Configuration Management: Ansible

4. Containers: Docker

5. Monitoring: Prometheus, Grafana

6. Registry: Amazon ECR

7. DNS & Security: Cloudflare

8. CI/CD: GitHub Actions (Documentation)

9. OS: Ubuntu 24.04



# Infrastructure Design (Terraform)

1️⃣ Terraform State

* Backend: Amazon S3

* Bucket Name:
  - devops-bootcamp-terraform-yourname

* Region: ap-southeast-1

2️⃣ Network Architecture

* VPC: 10.0.0.0/24 (devops-vpc)

* Subnets

  - Public Subnet: 10.0.0.0/25

  - Private Subnet: 10.0.0.128/25

* Gateways
     
  - Internet Gateway (Public Subnet)

  - NAT Gateway (Private Subnet)

3️⃣ Security Groups

* Web Server Security Group (devops-public-sg)

  - Port : 80	Source : 0.0.0.0/0
	
  - Port : 22	Sorce : VPC CIDR

* Ansible & Monitoring Security Group (devops-private-sg)

  - Port : 22	Source : VPC CIDR

4️⃣ EC2 Instances
 
 * Web Server/	         Public Subnet/	  Ip 10.0.0.5/       Elastic IP
 * Ansible Controller/   Private Subnet/	Ip 10.0.0.135/	     ❌
 * Monitoring Server/    Private Subnet/	Ip 10.0.0.136/	     ❌

5️⃣ Container Registry

Amazon ECR Repository
devops-bootcamp/final-project-mohdzulkefly

# ⚙ Application & Configuration Management (Ansible)

Web Application

- Repository:
  https://github.com/Infratify/lab-final-project

- Application Name: my-devops-project

- Deployment Method: Docker container

- Code modification: ❌ Not required

Web Server Configuration

* Using Ansible:

  - Install Docker Engine

  - Build or pull Docker image

  - Run my-devops-project container

  - Expose application on HTTP port 80

  - Access via mzulfly.com

Monitoring Server Configuration

* Using Ansible:

  - Install Docker Engine

* Deploy:

  - Prometheus

  - Grafana

* Configure Prometheus to scrape metrics from the web server


# 📊 Monitoring Implementation
* Prometheus Metrics

  - CPU Usage

  - Memory Usage

  - Disk Usage

* Grafana Dashboards

  - Grafana visualizes:

    I. CPU utilization

    II. Memory consumption

    III. Disk usage

 - Access:

    I. monitoring.mzulfly.com

    II. Only accessible via Cloudflare Tunnel

# 🔐 Access & Connectivity
* AWS Systems Manager (SSM)

  - Enabled on all EC2 instances

  - Used for troubleshooting and manual access

* Ansible Connectivity

  - SSH-based connectivity

  - SSM-based Ansible is optional (not required)



# 🌍 Domain & Cloudflare Setup

* Web Application

  - Domain: mzulfly.com

  - Points to Web Server Elastic IP

  - Cloudflare SSL Mode: Flexible

* Monitoring (Grafana)

  - Domain: monitoring.mzulfly.com

  - Access via Cloudflare Tunnel

  - Monitoring server has no public exposure

# 🔁 CI/CD (GitHub Actions)

* Mandatory

  - GitHub Actions used to deploy documentation to GitHub Pages

* Bonus

  - Build Docker image

  - Push image to Amazon ECR

  - Pull & run container on web server


# 🚀 Future Enhancements

    a) Alertmanager integration

    b) HTTPS termination using Nginx

    c) Full CI/CD pipeline for application deployment

    d) Infrastructure security hardening

    e) Migration to Kubernetes

# 👤 Author

Mohd Zulkefly
DevOps Bootcamp Participant



