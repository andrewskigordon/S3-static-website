resource "aws_s3_bucket" "m-1-1" {
  bucket = "m-1-1"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    website = "S3"
  }
}

#Object Ownership
resource "aws_s3_bucket_ownership_controls" "mrbucket" {
  bucket = aws_s3_bucket.m-1-1.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
#Block Public Access settings for this bucket
resource "aws_s3_bucket_public_access_block" "mrbucketson" {
  bucket = aws_s3_bucket.m-1-1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "m-1-1" {
  depends_on = [
    aws_s3_bucket_ownership_controls.mrbucket,
    aws_s3_bucket_public_access_block.mrbucketson,
  ]

  bucket = aws_s3_bucket.m-1-1.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "versioning_m-1-1" {
  bucket = aws_s3_bucket.m-1-1.id
  versioning_configuration {
    status = "Disabled"
  }
}





