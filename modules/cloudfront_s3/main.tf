locals {
  env_bucket       = "${var.prefix}-env-bucket-${var.environment}"
  media_bucket     = "${var.prefix}-media-bucket-${var.environment}"
  static_bucket    = "${var.prefix}-staticfiles-bucket-${var.environment}"
  media_origin_id  = "${var.prefix}-media-bucket-${var.environment}-origin"
  static_origin_id = "${var.prefix}-staticfiles-bucket-${var.environment}-origin"
  alb_origin_id    = "${var.prefix}-alb-${var.environment}-origin"
}

resource "aws_s3_bucket" "env_bucket" {
  bucket        = local.env_bucket
  force_destroy = true

  tags = {
    Name        = local.env_bucket
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "media_bucket" {
  bucket        = local.media_bucket
  force_destroy = true

  tags = {
    Name        = local.media_bucket
    Environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "media_bucket_policy" {
  bucket = aws_s3_bucket.media_bucket.bucket
  policy = data.aws_iam_policy_document.media_bucket_cloudfront_policy.json
}

resource "aws_s3_bucket" "staticfiles_bucket" {
  bucket        = local.static_bucket
  force_destroy = true

  tags = {
    Name        = local.static_bucket
    Environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "staticfiles_bucket_policy" {
  bucket = aws_s3_bucket.staticfiles_bucket.bucket
  policy = data.aws_iam_policy_document.staticfiles_bucket_cloudfront_policy.json
}



resource "aws_cloudfront_origin_access_control" "media_oac" {
  name                              = "${var.prefix}-media-oac-${var.environment}"
  signing_protocol                  = "sigv4"
  signing_behavior                  = "always"
  origin_access_control_origin_type = "s3"
}

resource "aws_cloudfront_origin_access_control" "staticfiles_oac" {
  name                              = "${var.prefix}-staticfiles-oac-${var.environment}"
  signing_protocol                  = "sigv4"
  signing_behavior                  = "always"
  origin_access_control_origin_type = "s3"
}

resource "aws_cloudfront_distribution" "cf_distro" {
  enabled             = true
  comment             = "${var.prefix}-cf-distro-${var.environment}"
  aliases             = var.cf_aliases
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  viewer_certificate {
    ssl_support_method       = "sni-only"
    acm_certificate_arn      = var.cf_acm_cert_arn
    minimum_protocol_version = "TLSv1.2_2021"
  }

  origin {
    domain_name              = aws_s3_bucket.staticfiles_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.staticfiles_oac.id
    origin_id                = local.static_origin_id
  }

  origin {
    domain_name              = aws_s3_bucket.media_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.media_oac.id
    origin_id                = local.media_origin_id
  }

  origin {
    domain_name = var.alb_dns_name
    origin_id   = local.alb_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = var.custom_header_name
      value = var.custom_header_value
    }
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  default_cache_behavior {
    compress = true

    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6" # AWS managed cache policy - CachingOptimized
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.static_origin_id
  }

  ordered_cache_behavior {
    path_pattern = "/api/*"

    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # AWS managed cache policy - CachingDisabled
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3" # AWS managed origin request policy - Managed-AllViewer
    viewer_protocol_policy   = "redirect-to-https"
    allowed_methods          = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "PATCH", "DELETE"]
    cached_methods           = ["GET", "HEAD"]
    target_origin_id         = local.alb_origin_id

  }

  ordered_cache_behavior {
    path_pattern = "/ws/*"

    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # AWS managed cache policy - CachingDisabled
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3" # AWS managed origin request policy - Managed-AllViewer
    viewer_protocol_policy   = "redirect-to-https"
    allowed_methods          = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "PATCH", "DELETE"]
    cached_methods           = ["GET", "HEAD"]
    target_origin_id         = local.alb_origin_id

  }

  ordered_cache_behavior {
    path_pattern = "/socialauth/*"

    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # AWS managed cache policy - CachingDisabled
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3" # AWS managed origin request policy - Managed-AllViewer
    viewer_protocol_policy   = "redirect-to-https"
    allowed_methods          = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "PATCH", "DELETE"]
    cached_methods           = ["GET", "HEAD"]
    target_origin_id         = local.alb_origin_id
  }
  ordered_cache_behavior {
    path_pattern = "/backdoor/*"

    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # AWS managed cache policy - CachingDisabled
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3" # AWS managed origin request policy - Managed-AllViewer
    viewer_protocol_policy   = "redirect-to-https"
    allowed_methods          = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "PATCH", "DELETE"]
    cached_methods           = ["GET", "HEAD"]
    target_origin_id         = local.alb_origin_id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "${var.prefix}-cf-distro-${var.environment}"
    Environment = var.environment
  }

}
