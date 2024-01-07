# variable "iam_role_name" {
#   description = "IAM role name to associate with the EC2 instance."
# }

# Number of instances to be created.
variable "instance_count" {
  type        = number
  description = "Number of instances to be created."
}

# Type of instance to be launched.
variable "instance_type" {
  type        = string
  description = "Instance type"
}

# Name of the PEM Key pair to be associated with the instances.
variable "key_name" {
  description = "Name of the PEM Key pair."
  type        = string
}

# List of security groups associated with the instances.
variable "security_groups" {
  type = list(string)
}

# ID of the VPC where the instances will be launched.
variable "vpc_id" {
  description = "ID of the VPC."
}

# AMI ID for the EC2 instances.
variable "ec2_ami" {
  type = string
}

# List of public subnets where the instances will be launched.
variable "public_subnet" {
  type = list(string)
}

# IAM role name to be associated with the EC2 instances.
variable "iam_role_name" {
  description = "IAM role name to associate with the EC2 instance."
}