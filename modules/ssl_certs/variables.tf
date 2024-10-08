variable "prefix" {
  type        = string
  description = "The prefix to apply to all resources"
}
variable "environment" {
  type        = string
  description = "The target environment"
}

variable "ssl_cert_path_body" {
  type        = string
  description = "The path to the SSL certificate body"
}

variable "ssl_cert_path_private_key" {
  type        = string
  description = "The path to the SSL certificate private key"
}

variable "ssl_cert_path_chain" {
  type        = string
  description = "The path to the SSL certificate chain"
}
