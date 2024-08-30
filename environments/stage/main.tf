variable "env_custom_cf_header_name" {
  type        = string
  description = "The name of the custom cloudfront header (env/tfvars)"
}

variable "env_custom_cf_header_value" {
  type        = string
  description = "The value of the custom cloudfront header (env/tfvars)"
}

module "core_infra" {
  source = "../../modules/_core"

  core_prefix                    = "eaportfolio"
  core_environment               = "stage"
  core_aws_region                = "us-west-2"
  core_env_filename              = "django-celery.env"
  core_cf_aliases                = ["stage.eaportfolio.com"]
  core_ssl_cert_path_body        = "../../certs/body.cert.pem"
  core_ssl_cert_path_private_key = "../../certs/private.key.pem"
  core_ssl_cert_path_chain       = "../../certs/chain.crt"
  core_custom_cf_header_name     = var.env_custom_cf_header_name
  core_custom_cf_header_value    = var.env_custom_cf_header_value

  providers = {
    aws             = aws
    aws.global_east = aws.global_east
  }
}
