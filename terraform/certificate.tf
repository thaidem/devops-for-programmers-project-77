resource "yandex_cm_certificate" "alb_cert" {
  name = "devops3-alb-letsencrypt"

  self_managed {
    certificate = file(var.tls_fullchain_pem_path)
    private_key = file(var.tls_privkey_pem_path)
  }
}
