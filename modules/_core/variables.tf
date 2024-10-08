variable "core_account_id" {
  type        = string
  description = "The target AWS account ID"
}
variable "core_prefix" {
  type        = string
  description = "The prefix to apply to all resources"
}

variable "core_environment" {
  type        = string
  description = "The target environment"
}

variable "core_aws_region" {
  type        = string
  description = "The AWS region to deploy to"
}

variable "core_env_filename" {
  type        = string
  description = "The name of the environment file"
}

variable "core_cf_aliases" {
  type        = list(string)
  description = "The aliases to apply to the CloudFront distribution"
}

variable "core_ssl_cert_path_body" {
  type        = string
  description = "The path to the SSL certificate body"
}

variable "core_ssl_cert_path_private_key" {
  type        = string
  description = "The path to the SSL certificate private key"
}

variable "core_ssl_cert_path_chain" {
  type        = string
  description = "The path to the SSL certificate chain"
}

variable "core_custom_cf_header_name" {
  type        = string
  description = "The name of the custom header cloudfront header"
}

variable "core_custom_cf_header_value" {
  type        = string
  description = "The value of the custom header cloudfront header"
}

variable "core_github_openid_role_name" {
  type        = string
  description = "The name of the GitHub OpenID Connect role"
}

variable "core_ecr_repo_name" {
  type        = string
  description = "The ECR repository name"
}

variable "core_migrate_task_name" {
  type        = string
  description = "The name of the migration task"
}

variable "core_api_cluster_name" {
  type        = string
  description = "The name of the API cluster"
}

variable "core_DJANGO_SETTINGS_MODULE" {
  type        = string
  description = "The Django settings module"
}

variable "core_rds_username" {
  type        = string
  description = "The RDS username"
}

variable "core_rds_password" {
  type        = string
  description = "The RDS password"
}

variable "core_rds_db_name" {
  type        = string
  description = "The RDS database name"
}
