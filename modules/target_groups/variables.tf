variable "vpc_id" {
  description = "The VPC ID where the target group will be created."
  type        = string
}

variable "aws_instance_ids" {
  description = "List of EC2 instance IDs to attach to the target group."
  type        = list(string)
}

variable "target_group_names" {
  # type    = list(string)
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


