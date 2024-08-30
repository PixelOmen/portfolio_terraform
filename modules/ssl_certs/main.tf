resource "aws_acm_certificate" "acm_cf_cert" {
  provider = aws.global_east

  certificate_body  = file(var.ssl_cert_path_body)
  private_key       = file(var.ssl_cert_path_private_key)
  certificate_chain = file(var.ssl_cert_path_chain)

  tags = {
    Name        = "${var.prefix}-cf-cert-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_acm_certificate" "acm_alb_cert" {
  certificate_body  = file(var.ssl_cert_path_body)
  private_key       = file(var.ssl_cert_path_private_key)
  certificate_chain = file(var.ssl_cert_path_chain)

  tags = {
    Name        = "${var.prefix}-alb-cert-${var.environment}"
    Environment = var.environment
  }
}
