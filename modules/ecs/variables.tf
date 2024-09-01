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

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "api_cluster_name" {
  type        = string
  description = "The name of the API cluster"
}

variable "ecr_repo_name" {
  type        = string
  description = "The ECR repository name"
}

variable "migrate_task_name" {
  type        = string
  description = "The name of the migration task"
}

variable "django_api_tg_arn" {
  type        = string
  description = "The ARN of the Django API target group"
}

variable "execution_role_arn" {
  type        = string
  description = "The ARN of the execution role"
}

variable "task_role_arn" {
  type        = string
  description = "The ARN of the task role"
}

variable "env_bucket_arn" {
  type        = string
  description = "The ARN of the environment bucket"
}

variable "env_filename" {
  type        = string
  description = "The name of the environment file"
}

variable "DJANGO_SETTINGS_MODULE" {
  type        = string
  description = "The Django settings module"
}

variable "api_sg_id" {
  type        = string
  description = "The ID of the API security group"
}

variable "rds_sg_id" {
  type        = string
  description = "The ID of the RDS security group"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The IDs of the private subnets"
}
