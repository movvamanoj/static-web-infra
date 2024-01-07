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