locals {
  env_bucket    = "${var.prefix}-env-bucket-${var.environment}"
  media_bucket  = "${var.prefix}-media-bucket-${var.environment}"
  static_bucket = "${var.prefix}-staticfiles-bucket-${var.environment}"
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

resource "aws_s3_bucket" "staticfiles_bucket" {
  bucket        = local.static_bucket
  force_destroy = true

  tags = {
    Name        = local.static_bucket
    Environment = var.environment
  }
}

# resource "aws_cloudfront_distribution" "cf_distro" {
#   comment = "${var.prefix}-${var.environment}-cf-distro"
#   retain_on_delete = true
# }
