resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  acl    = var.acl_public_read
  force_destroy = true
  

  website {
    index_document = var.index_document_main
    error_document = var.error_document_main
  }
}

# resource "aws_s3_bucket_object" "local_files" {
#   for_each = fileset(var.local_files_path, "*")

#   bucket = aws_s3_bucket.main.bucket
#   key    = each.value
#   source = "${var.local_files_path}/${each.value}"
# }

# resource "aws_s3_bucket_object" "github_files" {
#   for_each = toset(var.github_files)
#   bucket = aws_s3_bucket.main.bucket
#   key    = each.value
#   source = "https://raw.githubusercontent.com/movvamanoj/static-webhost/main/${each.value}"
# }
# terraform {
#   required_providers {
#     http = {
#       source = "hashicorp/http"
#     }
#   }
# }

# data "http" "github_files" {
#   url = var.github_files_url
# }

# resource "aws_s3_bucket_object" "github_files" {
#   for_each = { for file in jsondecode(data.http.github_files.body) : file.name => file }
#   bucket = aws_s3_bucket.main.bucket
#   key    = each.value.name
#   source = each.value.download_url
# }

resource "aws_iam_role_policy_attachment" "s3_attachment" {
  role       = var.s3_role_name
  policy_arn = var.s3_policy_arn
}
