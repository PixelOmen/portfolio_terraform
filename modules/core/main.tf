module "ssl_certs" {
  source = "../ssl_certs"

  ssl_cert_path_body        = var.core_ssl_cert_path_body
  ssl_cert_path_private_key = var.core_ssl_cert_path_private_key
  ssl_cert_path_chain       = var.core_ssl_cert_path_chain
}
module "cloudfront_s3" {
  source = "../cloudfront_s3"

  environment     = var.core_environment
  prefix          = var.core_prefix
  cf_aliases      = var.core_cf_aliases
  cf_acm_cert_arn = module.ssl_certs.acm_cf_cert.arn
}

# module "vpc" {
#   source = "../vpc"

#   environment = var.core_environment
#   aws_region  = var.core_aws_region
#   prefix      = var.core_prefix
# }
