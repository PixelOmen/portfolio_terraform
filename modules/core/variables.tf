variable "core_environment" {
  type        = string
  description = "The target environment"
}

variable "core_aws_region" {
  type        = string
  description = "The AWS region to deploy to"
}

variable "core_prefix" {
  type        = string
  description = "The prefix to apply to all resources"
}

variable "core_env_filename" {
  type        = string
  description = "The name of the environment file"
}
