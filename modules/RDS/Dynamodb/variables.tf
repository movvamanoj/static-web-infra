variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
}

variable "dynamodb_partition_key" {
  description = "Partition key for the DynamoDB table"
}

variable "dynamodb_sort_key" {
  description = "Sort key for the DynamoDB table"
}

variable "dynamodb_terraform_locks" {
  description = "terraform locks in dynamodb"
  
}