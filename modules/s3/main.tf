resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  acl    = var.acl_public_read
  force_destroy = true
  
  website {
    index_document = var.index_document_main
    error_document = var.error_document_main
  }
}

provider "http" {}

data "http" "github_files" {
  url = var.github_files_url
}

resource "aws_s3_bucket_object" "github_files" {
  for_each = { for file in jsondecode(data.http.github_files.body) : file.name => file }
  bucket = aws_s3_bucket.main.bucket
  key    = each.value.name
  source = each.value.download_url
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

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.main.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.s3_role_arn
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.main.arn}/*",
      },
    ],
  })
}



resource "aws_s3_bucket" "terraform_state" {
  bucket = var.s3_bucket_name
  acl    = "private"
  versioning {
    enabled = true
  }

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "Dev"
  }
}

resource "aws_iam_role" "terraform_backend_role" {
  name = "your_backend_role"
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


