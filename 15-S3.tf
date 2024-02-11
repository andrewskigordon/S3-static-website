resource "aws_s3_bucket" "m-1-1" {
  bucket = "m-1-1"
  force_destroy = true
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    website = "S3"
  }
}


resource "aws_s3_object" "m-1-1" {
  bucket = "m-1-1"
  key    = "index.html"
  source = "C:/Users/Andrew/Desktop/Terraform/AWS/s3-website/S3-static-website/index.html"
  content_type = "text/html"
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("C:/Users/Andrew/Desktop/Terraform/AWS/s3-website/S3-static-website/index.html")
}

#Object Ownership
resource "aws_s3_bucket_ownership_controls" "mrbucket" {
  bucket = aws_s3_bucket.m-1-1.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
#Block Public Access settings for this bucket
resource "aws_s3_bucket_public_access_block" "mrbucketson" {
  bucket = aws_s3_bucket.m-1-1.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning_m-1-1" {
  bucket = aws_s3_bucket.m-1-1.id
  versioning_configuration {
    status = "Disabled"
  }
}
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.m-1-1.id
  policy = jsonencode({
    Version = "2008-10-17"
    Id      = "PolicyForCloudFrontPrivateContent"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.m-1-1.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.s3_distribution.arn
          }
        }
      }
    ]
  })
}




