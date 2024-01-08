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

# terraform {
#   backend "s3" {
#     bucket         = "s3-terraform-state-files"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
