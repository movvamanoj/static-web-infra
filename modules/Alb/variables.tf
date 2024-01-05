#---------------------------------------------------------------------
# Terraform Variables For AWS ALB Configuration
#
# Author: movvmanoj
# Created: September 11, 2023
# Copyright (c) 2023 S. All rights reserved.
#---------------------------------------------------------------------
# This file defines variables used in the Terraform configuration.

# VPC ID where the target group will be created.
variable "vpc_id" {
  description = "The VPC ID where the target group will be created."
  type        = string
}

# List of EC2 instance IDs to attach to the target group.
variable "aws_instance_ids" {
  description = "List of EC2 instance IDs to attach to the target group."
  type        = list(string)
}

# List of target group ARNs (provide values if needed).
variable "target_group_arns" {
  type    = list(string)
  default = [] # Provide the list of target group ARNs here
}

# List of security groups associated with the ALB.
variable "security_groups" {
  type        = list(string)
}

# Number of target groups to be created.
variable "target_group_count" {
  type    = number
}

# Number of instances to be associated with the target group.
variable "instance_count" {
  type        = number
  description = "we are providing instance count" 
}

# Number of ALBs to be created.
variable "alb_count" {
  type    = number
}

# List of availability zones for subnets (provide values if needed).
variable "subnet_availability_zones" {
  type    = list(string)
  default = []  # Provide the list of availability zones here
}

# Number of CIDR blocks for public subnets.
variable "public_subnet_cidrs_count" {
  description = "List of CIDR blocks for subnets"
  type        = number
}

# List of CIDR blocks for public subnets (provide values if needed).
variable "public_subnet" {
  type    = list(string)
  default = []  # Provide the default value as needed
}

# Number of Availability Zones in the region.
variable "az_count" {
  description = "Number of Availability Zones in the region"
  type        = number
}