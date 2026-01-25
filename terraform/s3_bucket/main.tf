terraform {
  backend "s3" {
    bucket  = "mohdzulkefly-terraform-state-ap-southeast-1-2026"
    key     = "terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true
  }
}
provider "aws" {
  region = "ap-southeast-1"   # Malaysia/Singapore region
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "mohdzulkefly-terraform-state-ap-southeast-1-2026"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
