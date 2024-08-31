module "core_infra" {
  source = "../../modules/_core"

  core_prefix                    = "eaportfolio"
  core_environment               = "stage"
  core_aws_region                = "us-west-2"
  core_env_filename              = "django-celery.env"
  core_ssl_cert_path_body        = "../../certs/body.cert.pem"
  core_ssl_cert_path_private_key = "../../certs/private.key.pem"
  core_ssl_cert_path_chain       = "../../certs/chain.crt"
  core_account_id                = var.env_account_id
  core_cf_aliases                = var.env_cf_stage_aliases
  core_custom_cf_header_name     = var.env_custom_cf_header_name
  core_custom_cf_header_value    = var.env_custom_cf_header_value
  core_github_openid_role_arn    = var.env_github_openid_role_arn

  providers = {
    aws             = aws
    aws.global_east = aws.global_east
  }
}
