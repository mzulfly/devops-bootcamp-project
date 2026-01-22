
# Create an ECR Repository
resource "aws_ecr_repository" "final_project" {
  name                 = "devops-bootcamp/final-project-mohdzulkefly"  # replace yourname
  image_tag_mutability  = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "devops-bootcamp"
    Project     = "final-project"
  }
}

# Output the repository URL
output "ecr_repository_url" {
  value = aws_ecr_repository.final_project.repository_url
}
