# module "ssl_certs" {
#   source = "../ssl_certs"

#   prefix                    = var.core_prefix
#   environment               = var.core_environment
#   ssl_cert_path_body        = var.core_ssl_cert_path_body
#   ssl_cert_path_private_key = var.core_ssl_cert_path_private_key
#   ssl_cert_path_chain       = var.core_ssl_cert_path_chain

#   providers = {
#     aws             = aws
#     aws.global_east = aws.global_east
#   }
# }

module "vpc" {
  source = "../vpc"

  prefix      = var.core_prefix
  environment = var.core_environment
  aws_region  = var.core_aws_region
}

# module "security_groups" {
#   source = "../security_groups"

#   prefix      = var.core_prefix
#   environment = var.core_environment
#   vpc_id      = module.vpc.main_vpc.id
# }

# module "ecs_alb" {
#   source = "../ecs_alb"

#   prefix                 = var.core_prefix
#   environment            = var.core_environment
#   vpc_id                 = module.vpc.main_vpc.id
#   alb_subnet_ids         = module.vpc.public_subnet_ids
#   alb_security_group_ids = [module.security_groups.alb_sg.id]
#   acm_alb_cert_arn       = module.ssl_certs.acm_alb_cert.arn
#   custom_header_name     = var.core_custom_cf_header_name
#   custom_header_value    = var.core_custom_cf_header_value
# }

# module "cloudfront_s3" {
#   source = "../cloudfront_s3"

#   prefix              = var.core_prefix
#   environment         = var.core_environment
#   cf_aliases          = var.core_cf_aliases
#   cf_acm_cert_arn     = module.ssl_certs.acm_cf_cert.arn
#   alb_dns_name        = module.ecs_alb.alb.dns_name
#   custom_header_name  = var.core_custom_cf_header_name
#   custom_header_value = var.core_custom_cf_header_value
# }

