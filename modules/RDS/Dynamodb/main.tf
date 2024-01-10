resource "aws_dynamodb_table" "main" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.dynamodb_partition_key
  range_key      = var.dynamodb_sort_key
  # read_capacity  = 5
  # write_capacity = 5

  attribute {
    name = var.dynamodb_partition_key
    type = "S"
  }

  attribute {
    name = var.dynamodb_sort_key
    type = "S"
  }
}

# resource "aws_dynamodb_table" "terraform_locks_table" {
#   name           = var.dynamodb_terraform_locks
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# resource "aws_iam_role" "terraform_backend_role" {
#   name = "terraform-backend-role"
  
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "s3.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

