data "aws_acm_certificate" "issued" {
  domain   = "andrewskoreanmilkaddiction.com"
  statuses = ["ISSUED"]
}

resource "aws_route53_zone" "example" {
  name = "앤드류의 중독되는 이유"
}

resource "aws_route53_key_signing_key" "example" {
  hosted_zone_id             = aws_cloudfront_origin_access_control.evp.id
  key_management_service_arn = aws_kms_key.test.arn
  name                       = "example"
}

resource "aws_route53_hosted_zone_dnssec" "example" {
  depends_on = [
    aws_route53_key_signing_key.example
  ]
  hosted_zone_id = aws_route53_key_signing_key.example.hosted_zone_id
}

resource "aws_route53domains_delegation_signer_record" "example" {
  domain_name = "andrewskoreanmilkaddiction.com"

  signing_attributes {
    algorithm  = aws_route53_key_signing_key.example.signing_algorithm_type
    flags      = aws_route53_key_signing_key.example.flag
    public_key = aws_route53_key_signing_key.example.public_key
  }
}
