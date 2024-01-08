variable "region" {
  description = "Aws Region"
  type        = string
}

# variable "timeout" {
#   type = string
# }

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

# variable "alb_count" {
#   description = "Number of Availability Zones in the region"
#   type = number
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

variable "public_route_table_tag_name" {
    type = string
    description = "Public Route Table Tag Name"  
}

##target_group



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
variable "target_group_arns" {
  type    = list(string)
  default = [] # Provide the list of target group ARNs here
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



# List of CIDR blocks for public subnets (provide values if needed).
variable "public_subnet" {
  type    = list(string)
  default = []  # Provide the default value as needed
}


################DyNAMODB##################

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type = string
}

variable "dynamodb_partition_key" {
  description = "Partition key for the DynamoDB table"
  type = string
}

variable "dynamodb_sort_key" {
  description = "Sort key for the DynamoDB table"
  type = string
}




#####################S3###################
variable "github_files_url" {
    description = "provide git hub url"
    type = string  
}

# variable "local_files_path" {
#   description = "Local path to the files to upload to S3"
# }

# variable "github_files" {
#   description = "List of GitHub files to copy to S3"
#   type        = list(string)
# }

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type = string
}

variable "acl_public_read" {
    description = "Public read"
    default = "public-read"
    type = string

}
variable "index_document_main" {
    description = "index.html is main file"
    default = "index.html"
    type = string

  
}
variable "error_document_main" {
    description = "error html file "
    default = "error.html"
    type = string
}

variable "dynamodb_terraform_locks" {
  description = "provide terrafrom locks"
  type = string
  
}

variable "terraform_state" {
  description = "provide state file" 
}
variable "terraform_tfstate_key" {
  description = "terraform tfstate key"
}
variable "s3_terraform_state" {
  description = "terraform state files"
  type = string
}