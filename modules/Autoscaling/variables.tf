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

variable "region" {
  description = "AWS region"
}

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

variable "instance_type" {
  description = "EC2 instance type for the Auto Scaling Group"
}

variable "ec2_ami" {
  description = "AMI ID for the instances in the Auto Scaling Group"
}

variable "public_subnet" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}
