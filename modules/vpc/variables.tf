variable "environment" {
  type        = string
  description = "The target environment"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy to"
}

variable "prefix" {
  type        = string
  description = "The prefix to apply to all resources"
}
