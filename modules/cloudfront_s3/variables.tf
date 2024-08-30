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
