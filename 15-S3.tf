resource "aws_s3_bucket" "m-1-1" {
  bucket = "m-1-1"
  force_destroy = true
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





