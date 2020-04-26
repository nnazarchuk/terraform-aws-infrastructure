provider "aws" {
  region = "us-east-1"
}

module "base" {
  source = "./base"
}
