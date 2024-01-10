# AWS Provider Configuration
provider "aws" {
  region = var.region
}

# provider "github" {
#   token = "ghp_,_0tuAwsicgwvGCAnvaRMdzdbB17Mxq015xzOs"
#   # token = var.github_token # your GitHub personal access token
#   # owner = var.github_owner # your GitHub username or organization name
# }

# provider "aws" {
#   region = "us-east-2" # Set your desired AWS region here
# }
# Data Source for Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

terraform {
  backend "s3" {
    bucket         = "terr-state-file-backup-1808"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
