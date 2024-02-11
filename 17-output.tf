output "s3_url" {
  description = "S3 hosting URL (HTTP)"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}
