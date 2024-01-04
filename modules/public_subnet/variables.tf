variable "base_cidr_block" {
  description = "Base CIDR block for public subnets"
  # default     = "10.0.1"
}

variable "cidr_suffix" {
  description = "CIDR suffix for public subnets"
  # default     = ".0/24"
}

variable "public_subnet_name_tag" {
  description = "Public Subnet Tag Name"
  type = string  
}
# ID of the VPC.
variable "vpc_id" {
  type = string
  description = "ID of the VPC"
}
# Number of public subnet CIDR blocks.
variable "public_subnet_cidrs_count" {
  description = "List of CIDR blocks for subnets"
  type        = number
}
