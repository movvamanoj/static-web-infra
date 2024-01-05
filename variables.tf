variable "region" {
  description = "Aws Region"
  type        = string
}

variable "timeout" {
  type = string
}

variable "vpc_cidr" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_cidrs_count" {
  description = "List of CIDR blocks for subnets"
  type        = number
}
variable "key_name" {
  description = "pem Key pair"
  type = string
}

variable "instance_type" {
  type = string
  description = "instance t2.micro"
}

variable "ec2_ami" {
  type = string
  description = "instance ami"
}

variable "iam_role_name" {
  description = "IAM role name to associate with the EC2 instance."
}

variable "instance_count" {
  type = number
  description = "we are providing instance count "
  
}

variable "role_name" {
  description = "The name of the IAM role."
}

variable "ig_tag_name" {
    description = "Inetrnet Gateway Tag Name"
}

variable "base_cidr_block" {
  description = "Base CIDR block for public subnets"
  type = string

}

variable "cidr_suffix" {
  description = "CIDR suffix for public subnets"
  type = string
}

variable "public_subnet_name_tag" {
  description = "Public Subnet Tag Name"
  type = string  
}

variable "alb_count" {
  description = "Number of Availability Zones in the region"
  type = number
}

#########POSTGRESQL
variable "postgres_subnet_group_name" {
  description = "The name of the PostgreSQL RDS subnet group"
  type        = string
}

variable "postgres_allocated_storage" {
  description = "The allocated storage for the PostgreSQL RDS instance"
  type        = number
}

variable "postgres_storage_type" {
  description = "The storage type for the PostgreSQL RDS instance"
  type        = string
}

variable "postgres_engine" {
  description = "The database engine for the PostgreSQL RDS instance"
  type        = string
}

variable "postgres_engine_version" {
  description = "The engine version for the PostgreSQL RDS instance"
  type        = string
}

variable "postgres_instance_class" {
  description = "The instance class for the PostgreSQL RDS instance"
  type        = string
}

variable "postgres_db_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

# variable "postgres_username" {
#   description = "The username for the PostgreSQL database"
#   type        = string
# }

# variable "postgres_password" {
#   description = "The password for the PostgreSQL database"
#   type        = string
# }

variable "postgres_parameter_group_name" {
  description = "The name of the PostgreSQL parameter group"
  type        = string
}

variable "postgres_db_security_group_name" {
  description = "The name of the security group for the PostgreSQL RDS instance"
  type        = string
}

variable "postgres_db_security_group_description" {
  description = "The description of the security group for the PostgreSQL RDS instance"
  type        = string
}
variable "postgres_db_count" {
  type = number
  description = "we need to provide postgres_db_count basing on this it will create postgres_dbs"
  
}
 ###vault
variable "vault_address" {
  type = string
}

variable "vault_token" {
  type = string#required
}

variable "vault_path" {
  type = string #required
}

# variable "postgres_db_username" {
#   default = data.vault_generic_secret.aws_rds_postgres_credentials.data["my_postgres_db_username"]
# }

# variable "postgres_db_password" {
#   default = data.vault_generic_secret.aws_rds_postgres_credentials.data["my_postgres_db_password"]
# }


####AUtoScaling 

variable "tag_key" {
  description = "Key for the tag on the Auto Scaling Group"
}

variable "tag_value" {
  description = "Value for the tag on the Auto Scaling Group"
  default     = "AutoScalingInstance"
}

variable "tag_propagate_at_launch" {
  description = "Whether to propagate the tag to instances launched in the Auto Scaling Group"
  type = bool
}

variable "lifecycle_create_before_destroy" {
  description = "Whether to propagate the tag to instances launched in the Auto Scaling Group"
  type = bool
}

# variable "region" {
#   description = "AWS region"
# }

variable "asg_name" {
  description = "Name for the Auto Scaling Group"
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
}

variable "launch_config_name" {
  description = "Name for the Launch Configuration"
}

# variable "instance_type" {
#   description = "EC2 instance type for the Auto Scaling Group"
# }

# variable "ami_id" {
#   description = "AMI ID for the instances in the Auto Scaling Group"
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs for the Auto Scaling Group"
#   type        = list(string)
# }

variable "public_route_table_tag_name" {
    type = string
    description = "Public Route Table Tag Name"  
}

##target_group

variable "vpc_id" {
  description = "The VPC ID where the target group will be created."
  type        = string
}

variable "aws_instance_ids" {
  description = "List of EC2 instance IDs to attach to the target group."
  type        = list(string)
}


variable "target_group_names" {
  # target-group-
#   default = []  # Leave this empty since the names are generated automatically
}

variable "target_group_count" {
  type    = number
#   default = 3  # Set the default count as needed
}

variable "target_instance_count" {
  type        = number
  description = "Number of instances to attach to the target groups."
}

variable "target_group_port" {
  description = "Port for the target groups."
  type        = number
#   default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target groups."
  type        = string
#   default     = "HTTP"
}

variable "health_check_path" {
  description = "Path for the health check."
  type        = string
#   default     = "/"
}

variable "health_check_port" {
  description = "Port for the health check."
  type        = number
#   default     = 80
}

variable "health_check_interval" {
  description = "Interval (in seconds) between health checks."
  type        = number
#   default     = 30
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive successful health checks to be considered healthy."
  type        = number
#   default     = 3
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive failed health checks to be considered unhealthy."
  type        = number
#   default     = 2
}


#######alb

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