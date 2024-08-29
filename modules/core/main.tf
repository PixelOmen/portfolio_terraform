module "cloudfront_s3" {
  source = "../cloudfront_s3"

  environment = var.core_environment
  prefix      = var.core_prefix
}

# module "vpc" {
#   source = "../vpc"

#   environment = var.core_environment
#   aws_region  = var.core_aws_region
#   prefix      = var.core_prefix
# }
