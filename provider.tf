# AWS Provider Configuration
provider "aws" {
  region = var.region
}
# provider "aws" {
#   region = "us-east-2" # Set your desired AWS region here
# }
# Data Source for Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

terraform {
  backend "s3" {
    bucket         = var.s3_terraform_state
    key            = var.terraform_tfstate_key
    region         = var.region
    encrypt        = true
    dynamodb_table = var.dynamodb_terraform_locks


    assume_role {
      role_arn = module.iam_backend.backend_role_arn
    }
  }
}
