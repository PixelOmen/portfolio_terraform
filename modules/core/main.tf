module "cloudfront_s3" {
  source = "../cloudfront_s3"

  environment     = var.core_environment
  prefix          = var.core_prefix
  cf_alies        = var.core_cf_alies
  cf_acm_cert_arn = var.core_cf_acm_cert_arn
}

# module "vpc" {
#   source = "../vpc"

#   environment = var.core_environment
#   aws_region  = var.core_aws_region
#   prefix      = var.core_prefix
# }
