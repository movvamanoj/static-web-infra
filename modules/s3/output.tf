output "s3_bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "s3_bucket_endpoint" {
  value = aws_s3_bucket.main.website_endpoint
}

output "backend_role_arn" {
  value = aws_iam_role.terraform_backend_role.arn
}

output "backend_role_name" {
  value = aws_iam_role.terraform_backend_role.name
}