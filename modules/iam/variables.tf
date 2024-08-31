variable "prefix" {
  type        = string
  description = "The prefix for the resources"
}

variable "environment" {
  type        = string
  description = "The target environment"
}

variable "region" {
  type        = string
  description = "The target region"
}

variable "account_id" {
  type        = string
  description = "The target AWS account ID"
}

variable "env_bucket_arn" {
  type        = string
  description = "The ARN of the environment bucket"
}

variable "media_bucket_arn" {
  type        = string
  description = "The ARN of the media bucket"
}

variable "staticfiles_bucket_arn" {
  type        = string
  description = "The ARN of the staticfiles bucket"

}

variable "github_openid_role_name" {
  type        = string
  description = "The name of the GitHub OpenID Connect role"
}

variable "cf_distro_id" {
  type        = string
  description = "The ID of the CloudFront distribution"
}

variable "ecr_repo_name" {
  type        = string
  description = "The ECR repository name"
}

variable "migrate_task_name" {
  type        = string
  description = "The name of the migration task"
}

variable "api_cluster_name" {
  type        = string
  description = "The name of the API cluster"
}
