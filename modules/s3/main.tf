resource "aws_s3_bucket" "static-website" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_website_configuration" "static-website" {
  bucket = aws_s3_bucket.static-website.id

  index_document {
    suffix = var.index_document_main
  }

  error_document {
    # key = var.error_document_main
    key = var.index_document_main
  }
}

resource "aws_s3_bucket_versioning" "static-website" {
  bucket = aws_s3_bucket.static-website.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket ACL access

resource "aws_s3_bucket_ownership_controls" "static-website" {
  bucket = aws_s3_bucket.static-website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static-website" {
  bucket = aws_s3_bucket.static-website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "static-website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static-website,
    aws_s3_bucket_public_access_block.static-website,
  ]

  bucket = aws_s3_bucket.static-website.id
  acl    = "public-read"
}


# S3 bucket policy
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.static-website.id

  policy = <<POLICY
{
  "Id": "Policy",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.static-website.bucket}/*",
      "Principal": {
        "AWS": [
          "*"
        ]
      }
    }
  ]
}
POLICY
}


resource "null_resource" "static-website_object_provisioner" {
  depends_on = [aws_s3_bucket.static-website]

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]

    command = <<-EOT
      (Get-Content "${path.module}/files/script.js") -replace 'const backendUrl = .*;', 'const backendUrl = ''http://${var.alb_dns_name}:3000'';' | Set-Content "${path.module}/files/script.js"
    EOT
  }
}


# Inside the aws_s3_bucket module
resource "aws_s3_bucket_object" "local_files" {
  for_each   = fileset("${path.module}/files", "*")
  bucket     = aws_s3_bucket.static-website.bucket
  key        = each.value
  source     = "${path.module}/files/${each.value}"
  etag       = filemd5("${path.module}/files/${each.value}")
  acl        = "public-read"
  force_destroy = true
  depends_on = [null_resource.static-website_object_provisioner]

  # Set the correct Content-Type
  content_type = each.value == "index.html" ? "text/html" : each.value == "style.css" ? "text/css" : each.value == "script.js" ? "application/javascript" : each.value == "script.py" ? "text/x-python" : "application/octet-stream"
}



# # Create a bucket for the Terraform state
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = var.s3_bucket_name
#   acl    = "private"
#   versioning {
#     enabled = true
#   }
#   tags = {
#     Name        = "TerraformStateBucket"
#     Environment = "Dev"
#   }

#    # Add the prevent_destroy lifecycle block
#   lifecycle {
#     prevent_destroy = true
#   }

# }

# # Block public access to the Terraform state bucket
# resource "aws_s3_bucket_public_access_block" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }