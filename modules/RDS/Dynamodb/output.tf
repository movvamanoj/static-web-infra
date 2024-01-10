output "dynamodb_table_name" {
  value = aws_dynamodb_table.main.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.main.arn
}

# output "backend_role_arn" {
#   value = aws_iam_role.terraform_backend_role.arn
# }

# output "backend_role_name" {
#   value = aws_iam_role.terraform_backend_role.name
# }

# output "terra_dynamodb_table_name" {
#   value = aws_dynamodb_table.terraform_locks_table.name
# }