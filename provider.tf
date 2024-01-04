# AWS Provider Configuration
provider "aws" {
  region = var.region
}

# Data Source for Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}