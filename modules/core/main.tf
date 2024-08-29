module "vpc" {
  source = "../vpc"

  environment = var.core_environment
  aws_region  = var.core_aws_region
  prefix      = var.core_prefix
}
