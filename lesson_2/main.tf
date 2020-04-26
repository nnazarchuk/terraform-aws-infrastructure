provider "aws" {
  region = "us-east-1"
}

locals {
  user_data = file("${path.module}/user_data/install.sh")
}

module "base" {
  source             = "../base"
  instance_user_data = local.user_data
}

resource "aws_s3_bucket" "devops_school" {
  bucket = "devops-school"

  tags = {
    Name = "DevOps School bucket"
  }
}

resource "aws_s3_bucket_object" "devops_school_image" {
  key    = "devops-school-image.png"
  bucket = aws_s3_bucket.devops_school.id
  source = "${path.module}/static/image.png"
  acl    = "public-read"
}
