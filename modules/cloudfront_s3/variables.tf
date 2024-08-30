variable "environment" {
  type        = string
  description = "The target environment"
}

variable "prefix" {
  type        = string
  description = "The prefix to apply to all resources"
}

variable "cf_aliases" {
  type        = list(string)
  description = "The aliases to apply to the CloudFront distribution"
}

variable "cf_acm_cert_arn" {
  type        = string
  description = "The ARN of the ACM certificate to use for the CloudFront distribution"
}

variable "alb_dns_name" {
  type        = string
  description = "The ALB to use as the origin for the CloudFront distribution"
}

variable "custom_header_name" {
  type        = string
  description = "The name of the custom header cloudfront header"
}

variable "custom_header_value" {
  type        = string
  description = "The value of the custom header cloudfront header"
}
