output "iam_role_arn" {
  value = aws_iam_role.static_website_role.arn
}

output "iam_role_name" {
  value = aws_iam_role.static_website_role.name
}

output "s3_role_arn" {
  value = aws_iam_role.s3_role.arn
}

output "s3_role_name" {
  value = aws_iam_role.s3_role.name
}