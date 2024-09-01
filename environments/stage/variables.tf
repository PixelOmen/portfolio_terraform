variable "env_account_id" {
  type        = string
  description = "The target AWS account ID (env/tfvars)"
}

variable "env_cf_stage_aliases" {
  type        = list(string)
  description = "The cloudfront aliases for stage env (env/tfvars)"
}
variable "env_custom_cf_header_name" {
  type        = string
  description = "The name of the custom cloudfront header (env/tfvars)"
}

variable "env_custom_cf_header_value" {
  type        = string
  description = "The value of the custom cloudfront header (env/tfvars)"
}

variable "env_github_openid_role_name" {
  type        = string
  description = "The github openid role arn (env/tfvars)"
}

variable "env_ecr_repo_name" {
  type        = string
  description = "The ecr repo name, without prefix/env (env/tfvars)"
}

variable "env_migrate_task_name" {
  type        = string
  description = "The name of the migration task, without prefix/env (env/tfvars)"
}

variable "env_api_cluster_name" {
  type        = string
  description = "The name of the API cluster, without prefix/env (env/tfvars)"
}
