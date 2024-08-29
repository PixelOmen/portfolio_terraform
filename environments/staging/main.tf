module "core_infra" {
  source = "../../modules/core"

  core_prefix       = "eaportfolio"
  core_aws_region   = "us-west-2"
  core_environment  = "stage"
  core_env_filename = "django-celery.env"
}
