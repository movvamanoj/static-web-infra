# ID of the VPC.
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

# ID of the Internet Gateway.
variable "gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
}

# Number of public subnet CIDR blocks.
variable "public_subnet_cidrs_count" {
  description = "Number of public subnet CIDR blocks"
  type        = number
}


# List of CIDR blocks for public subnets.
variable "public_subnet" {
  type    = list(string)
}

variable "public_route_table_tag_name" {
    type = string
    description = "Public Route Table Tag Name" 
}