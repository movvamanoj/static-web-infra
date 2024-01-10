
variable "region" {
  description = "Aws Region"
  type        = string
}

variable "s3_role_name" {
  description = "IAM role name to attach S3 policy"
}

variable "s3_role_arn" {
  description = "ARN of the S3 policy to attach"
}

# variable "local_files_path" {
#   description = "Local path to the files to upload to S3"
# }

# variable "github_files" {
#   description = "List of GitHub files to copy to S3"
#   type        = list(string)
# }
variable "alb_dns_name" {
  description = "The DNS names of the ALB"
  # type        = list(string)
  # default     = []  # Set the default value as an empty list or provide your default values
}

variable "github_files_url" {
    description = "provide git hub url"
    type = string  
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type = string
}

variable "s3_bucket_name" {
  type = string
  
}
variable "acl_public_read" {
    description = "read"
    default = "private"
    type = string

}
variable "index_document_main" {
    description = "index.html is main file"
    default = "index.html"


  
}

variable "error_document_main" {
    description = "error html file "
    default = "error.html"
}