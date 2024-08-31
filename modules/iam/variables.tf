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

variable "github_openid_role_arn" {
  type        = string
  description = "The ARN of the GitHub OpenID Connect role"
}
