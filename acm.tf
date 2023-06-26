resource "aws_acm_certificate" "cert" {
  private_key      = file(var.domain_setup.private_key)
  certificate_body = file(var.domain_setup.cert_body)
}
