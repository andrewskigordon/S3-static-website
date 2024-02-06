output "s3_url" {
  description = "S3 hosting URL (HTTP)"
  value       = aws_s3_bucket.m-1-1.bucket_regional_domain_name
}
