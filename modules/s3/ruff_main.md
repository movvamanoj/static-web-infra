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
# # Declare the null_resource outside the aws_s3_bucket module
# resource "null_resource" "static-website_object_provisioner" {
#   depends_on = [aws_s3_bucket.static-website]

#   # for dns_name in ${join(",", ${var.alb_dns_name})}
#   provisioner "local-exec" {
#     command = <<-EOT
#       for dns_name in ${var.alb_dns_name}
#       do
#         sed -i "s|const backendUrl = .*;|const backendUrl = 'http://$dns_name:3000';|" ${path.module}/files/script.js
#       done
#     EOT
#   }
# }
# Declare the null_resource outside the aws_s3_bucket module
resource "null_resource" "static-website_object_provisioner" {
  depends_on = [aws_s3_bucket.static-website]

  provisioner "local-exec" {
    command = <<-EOT
      for dns_name in "${var.alb_dns_name}"; do
        sed -i "s|const backendUrl = .*;|const backendUrl = 'http://$dns_name:3000';|" "${path.module}/files/script.js"
      done
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
  depends_on = [null_resource.static-website_object_provisioner]

  # Set the correct Content-Type
  content_type = each.value == "index.html" ? "text/html" : each.value == "style.css" ? "text/css" : each.value == "script.js" ? "application/javascript" : each.value == "script.py" ? "text/x-python" : "application/octet-stream"
}


# Create a bucket for the Terraform state
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

   # Add the prevent_destroy lifecycle block
  lifecycle {
    prevent_destroy = true
  }

}

# Block public access to the Terraform state bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}




# # Upload files from a local directory to the main bucket
# resource "aws_s3_bucket_object" "local_files" {
#   for_each = fileset("${path.module}/files", "*")
#   bucket   = aws_s3_bucket.static-website.bucket
#   key      = each.value
#   source   = "${path.module}/files/${each.value}"
#   etag     = filemd5("${path.module}/files/${each.value}")
#  provisioner "local-exec" {
#     command = <<-EOT
#       for dns_name in ${var.alb_dns_name}
#       do
#         sed -i "s|const backendUrl = .*;|const backendUrl = 'http://$dns_name:3000';|" ${path.module}/files/script.js
#       done
#     EOT
#   }
# }

# # Add a new data source for checking S3 bucket objects
# data "aws_s3_bucket_objects" "static-website" {
#   bucket = aws_s3_bucket.static-website.bucket
# }

# # Update the null_resource "delete_bucket" to depend on the new data source
# resource "null_resource" "delete_bucket" {
#   depends_on = [
#     aws_s3_bucket.static-website,
#     data.aws_s3_bucket_objects.static-website,
#   ]

#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     command = "aws s3 rb s3://${aws_s3_bucket.static-website.bucket} --force"
#   }
# }



























# Create a bucket for the main website
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  force_destroy = true
  acl      = "public-read" 


  website {
    index_document = var.index_document_main
    error_document = var.error_document_main
  }
}

# # Delete the bucket
# resource "null_resource" "delete_bucket" {
#   depends_on = [aws_s3_bucket.main]
#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     command = "aws s3 rb s3://terr-state-file-backup-1808 --force"
#   }
# }
# Block public access to the main bucket
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Upload files from a local directory to the main bucket
resource "aws_s3_bucket_object" "local_files" {
  for_each = fileset("${path.module}/files", "*")
  bucket = var.bucket_name
  key    = each.value
  source = "${path.module}/files/${each.value}"
  etag   = filemd5("${path.module}/files/${each.value}")
}

# Generate a policy for the main bucket
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.main.bucket

  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

# Create a policy document for the main bucket policy
data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::test-web-terra-1808/*"]
    # resources = ["${aws_s3_bucket.main.arn}/*"]
  }
}

# Create a bucket for the Terraform state
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

# Block public access to the Terraform state bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}




# Define the GitHub provider
# provider "github" {
#   token = var.github_token # your GitHub personal access token
#   owner = var.github_owner # your GitHub username or organization name
# }

# # Read the files from the GitHub repository
# data "github_repository_file" "github_files" {
#   for_each = fileset("static-webhost/", "*")

#   repository = "movvamanoj" # the name of the GitHub repository
#   branch     = "main"       # the name of the branch to read from
#   file       = each.value   # the path of the file to read
  
# }

# # Upload the files to the S3 bucket
# resource "aws_s3_bucket_object" "github_files" {
#   for_each = fileset("static-webhost/", "*")

#   bucket = aws_s3_bucket.main.id
#   key    = each.value
#   source = data.github_repository_file.github_files[each.value].content
#   etag   = data.github_repository_file.github_files[each.value].sha
# }

# # Define the GitHub provider
# provider "github" {
#   token = var.github_token # your GitHub personal access token
#   owner = var.github_owner # your GitHub username or organization name
# }

# # Read the files from the GitHub repository
# data "github_repository_file" "github_files" {
#   for_each = toset(var.github_files)

#   repository = var.github_repository # the name of the GitHub repository
#   branch     = var.github_branch     # the name of the branch to read from
#   file       = each.value            # the path of the file to read
# }

# # Upload the files to the S3 bucket
# resource "aws_s3_bucket_object" "github_files" {
#   for_each = toset(var.github_files)

#   bucket = aws_s3_bucket.main.id
#   key    = each.value
#   source = data.github_repository_file.github_files[each.value].content
#   etag   = data.github_repository_file.github_files[each.value].sha
# }



# # Create a CloudFront distribution for the main bucket
# resource "aws_cloudfront_distribution" "main" {
#   origin {
#     domain_name = aws_s3_bucket.main.bucket_regional_domain_name
#     origin_id   = aws_s3_bucket.main.id

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
#     }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   default_root_object = var.index_document_main

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = aws_s3_bucket.main.id

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "redirect-to-https"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   # Use the ACM certificate
#   viewer_certificate {
#     acm_certificate_arn      = aws_acm_certificate.main.arn
#     ssl_support_method       = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2019"
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }
# }

# # Create an origin access identity for the CloudFront distribution
# resource "aws_cloudfront_origin_access_identity" "main" {
#   comment = "Origin access identity for ${var.bucket_name}"
# }

# # Request a certificate for the domain name
# resource "aws_acm_certificate" "main" {
#   domain_name       = var.domain_name
#   validation_method = "DNS"
# }

# # Validate the certificate using DNS
# resource "aws_acm_certificate_validation" "main" {
#   certificate_arn         = aws_acm_certificate.main.arn
#   validation_record_fqdns = [for record in aws_route53_record.main_validation : record.fqdn]
# }

# # Create a DNS record for the domain name
# resource "aws_route53_record" "main" {
#   zone_id = var.zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = aws_cloudfront_distribution.main.domain_name
#     zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
#     evaluate_target_health = true
#   }
# }

# # Create a DNS record for the certificate validation
# resource "aws_route53_record" "main_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   zone_id = var.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   records = [each.value.record]
#   ttl     = 60
# }































# resource "aws_s3_bucket" "main" {
#   bucket = var.bucket_name
#   acl    = var.acl_public_read
#   force_destroy = true
#   # region = var.region
#   # region = "us-east-1"  
#   website {
#     index_document = var.index_document_main
#     error_document = var.error_document_main
#   }
# }

# # provider "http" {}

# # data "http" "github_files" {
# #   url = var.github_files_url
# # }

# # resource "aws_s3_bucket_object" "github_files" {
# #   for_each = { for file in jsondecode(data.http.github_files.body) : file.name => file }
# #   bucket = aws_s3_bucket.main.bucket
# #   key    = each.value.name
# #   source = each.value.download_url
# # }


# # resource "aws_s3_bucket_object" "local_files" {
# #   for_each = fileset(var.local_files_path, "*")

# #   bucket = aws_s3_bucket.main.bucket
# #   key    = each.value
# #   source = "${var.local_files_path}/${each.value}"
# # }

# # resource "aws_s3_bucket_object" "github_files" {
# #   for_each = toset(var.github_files)
# #   bucket = aws_s3_bucket.main.bucket
# #   key    = each.value
# #   source = "https://raw.githubusercontent.com/movvamanoj/static-webhost/main/${each.value}"
# # }

# resource "aws_s3_bucket_policy" "s3_bucket_policy" {
#   bucket = aws_s3_bucket.main.bucket

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           AWS = var.s3_role_arn
#         },
#         Action = "s3:GetObject",
#         Resource = "${aws_s3_bucket.main.arn}/*",
#       },
#     ],
#   })
# }



# resource "aws_s3_bucket" "terraform_state" {
#   bucket = var.s3_bucket_name
#   acl    = "private"
#   # region = var.region
#   versioning {
#     enabled = true
#   }

#   tags = {
#     Name        = "TerraformStateBucket"
#     Environment = "Dev"
#   }
# }

# # resource "aws_iam_role" "terraform_backend_role" {
# #   name = "terraform-backend-role"
  
# #   assume_role_policy = <<EOF
# # {
# #   "Version": "2012-10-17",
# #   "Statement": [
# #     {
# #       "Effect": "Allow",
# #       "Principal": {
# #         "Service": "s3.amazonaws.com"
# #       },
# #       "Action": "sts:AssumeRole"
# #     }
# #   ]
# # }
# # EOF
# # }


