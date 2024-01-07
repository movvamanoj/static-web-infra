variable "s3_role_name" {
  description = "IAM role name to attach S3 policy"
}

variable "s3_policy_arn" {
  description = "ARN of the S3 policy to attach"
}

# variable "local_files_path" {
#   description = "Local path to the files to upload to S3"
# }

# variable "github_files" {
#   description = "List of GitHub files to copy to S3"
#   type        = list(string)
# }

variable "github_files_url" {
    description = "provide git hub url"
    type = string  
}

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