resource "aws_acm_certificate" "acm_cf_cert" {
  provider = aws.global_east

  certificate_body  = file(var.ssl_cert_path_body)
  private_key       = file(var.ssl_cert_path_private_key)
  certificate_chain = file(var.ssl_cert_path_chain)
}

resource "aws_acm_certificate" "acm_alb_cert" {
  certificate_body  = file(var.ssl_cert_path_body)
  private_key       = file(var.ssl_cert_path_private_key)
  certificate_chain = file(var.ssl_cert_path_chain)
}
