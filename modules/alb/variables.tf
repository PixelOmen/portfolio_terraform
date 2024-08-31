variable "prefix" {
  type        = string
  description = "The prefix for the resources"
}

variable "environment" {
  type        = string
  description = "The target environment"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "alb_subnet_ids" {
  type        = list(string)
  description = "The subnets to attach the ALB to"
}

variable "alb_security_group_ids" {
  type        = list(string)
  description = "The security groups to attach the ALB to"
}

variable "acm_alb_cert_arn" {
  type        = string
  description = "The ARN of the ACM certificate to use for the ALB"
}

variable "custom_header_name" {
  type        = string
  description = "The name of the custom header cloudfront header"
}

variable "custom_header_value" {
  type        = string
  description = "The value of the custom header cloudfront header"
}
