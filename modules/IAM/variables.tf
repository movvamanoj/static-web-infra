variable "role_name" {
  description = "The name of the IAM role."
}

variable "s3_role_name" {
  description = "The name of the IAM role for S3."
  default = "s3-role"
}