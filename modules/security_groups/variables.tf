variable "prefix" {
  type        = string
  description = "The prefix to apply to all resources"
}

variable "environment" {
  type        = string
  description = "The target environment"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to associate with the security group"
}
