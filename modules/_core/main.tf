module "ssl_certs" {
  source = "../ssl_certs"

  prefix                    = var.core_prefix
  environment               = var.core_environment
  ssl_cert_path_body        = var.core_ssl_cert_path_body
  ssl_cert_path_private_key = var.core_ssl_cert_path_private_key
  ssl_cert_path_chain       = var.core_ssl_cert_path_chain

  providers = {
    aws             = aws
    aws.global_east = aws.global_east
  }
}

module "vpc" {
  source = "../vpc"

  prefix      = var.core_prefix
  environment = var.core_environment
  aws_region  = var.core_aws_region
}

module "security_groups" {
  source = "../security_groups"

  prefix      = var.core_prefix
  environment = var.core_environment
  vpc_id      = module.vpc.main_vpc.id
}

module "alb_module" {
  source = "../alb"

  prefix                 = var.core_prefix
  environment            = var.core_environment
  vpc_id                 = module.vpc.main_vpc.id
  alb_subnet_ids         = module.vpc.public_subnet_ids
  alb_security_group_ids = [module.security_groups.alb_sg.id]
  acm_alb_cert_arn       = module.ssl_certs.acm_alb_cert.arn
  custom_header_name     = var.core_custom_cf_header_name
  custom_header_value    = var.core_custom_cf_header_value
}

module "cloudfront_s3" {
  source = "../cloudfront_s3"

  prefix              = var.core_prefix
  environment         = var.core_environment
  cf_aliases          = var.core_cf_aliases
  cf_acm_cert_arn     = module.ssl_certs.acm_cf_cert.arn
  alb_dns_name        = module.alb_module.alb.dns_name
  custom_header_name  = var.core_custom_cf_header_name
  custom_header_value = var.core_custom_cf_header_value
}

module "iam" {
  source = "../iam"

  prefix                  = var.core_prefix
  environment             = var.core_environment
  region                  = var.core_aws_region
  account_id              = var.core_account_id
  ecr_repo_name           = var.core_ecr_repo_name
  github_openid_role_name = var.core_github_openid_role_name
  migrate_task_name       = var.core_migrate_task_name
  api_cluster_name        = var.core_api_cluster_name
  env_bucket_arn          = module.cloudfront_s3.env_bucket_arn
  media_bucket_arn        = module.cloudfront_s3.media_bucket_arn
  staticfiles_bucket_arn  = module.cloudfront_s3.staticfiles_bucket_arn
  cf_distro_id            = module.cloudfront_s3.cf_distro_id
}

module "ecs" {
  source = "../ecs"

  depends_on = [
    module.alb_module.alb,
    module.iam.execution_role,
    module.iam.task_role
  ]

  prefix                 = var.core_prefix
  environment            = var.core_environment
  region                 = var.core_aws_region
  account_id             = var.core_account_id
  ecr_repo_name          = var.core_ecr_repo_name
  migrate_task_name      = var.core_migrate_task_name
  api_cluster_name       = var.core_api_cluster_name
  env_filename           = var.core_env_filename
  DJANGO_SETTINGS_MODULE = var.core_DJANGO_SETTINGS_MODULE
  django_api_tg_arn      = module.alb_module.django_api_tg.arn
  execution_role_arn     = module.iam.execution_role.arn
  task_role_arn          = module.iam.task_role.arn
  env_bucket_arn         = module.cloudfront_s3.env_bucket_arn
  api_sg_id              = module.security_groups.api_sg.id
  rds_sg_id              = module.security_groups.rds_sg.id
  private_subnet_ids     = module.vpc.private_subnet_ids
}
