output "s3_bucket_endpoint" {
  value = module.s3_bucket.s3_bucket_endpoint
}

output "dynamodb_table_name" {
  value = module.dynamodb_table.dynamodb_table_name
}

output "dynamodb_table_arn" {
  value = module.dynamodb_table.dynamodb_table_arn
}