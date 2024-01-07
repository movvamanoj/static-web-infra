resource "aws_dynamodb_table" "main" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.dynamodb_partition_key
  range_key      = var.dynamodb_sort_key
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = var.dynamodb_partition_key
    type = "S"
  }

  attribute {
    name = var.dynamodb_sort_key
    type = "S"
  }
}
