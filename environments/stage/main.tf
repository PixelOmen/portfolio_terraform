module "core_infra" {
  source = "../../modules/core"

  core_environment               = "stage"
  core_aws_region                = "us-west-2"
  core_prefix                    = "eaportfolio"
  core_env_filename              = "django-celery.env"
  core_cf_aliases                = ["stage.eaportfolio.com"]
  core_ssl_cert_path_body        = "../../certs/body.cert.pem"
  core_ssl_cert_path_private_key = "../../certs/private.key.pem"
  core_ssl_cert_path_chain       = "../../certs/chain.crt"
}
