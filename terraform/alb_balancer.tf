resource "yandex_alb_target_group" "devops3-tg" {
  name = "devops3-tg"

  target {
    subnet_id  = yandex_vpc_subnet.devops3-subnet.id
    ip_address = yandex_compute_instance.app-server-1.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.devops3-subnet.id
    ip_address = yandex_compute_instance.app-server-2.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "devops3-bg" {
  name = "devops3-bg"

  http_backend {
    name             = "devops3-backend"
    weight           = 1
    port             = 3000
    target_group_ids = [yandex_alb_target_group.devops3-tg.id]
    healthcheck {
      timeout             = "1s"
      interval            = "1s"
      healthy_threshold   = 1
      unhealthy_threshold = 1
      healthcheck_port    = 3000
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "devops3-router" {
  name = "devops3-router"
}

resource "yandex_alb_virtual_host" "devops3-host" {
  name           = "devops3-host"
  http_router_id = yandex_alb_http_router.devops3-router.id

  route {
    name = "devops3-route"
    http_route {
      http_match {
        path {
          prefix = "/"
        }
      }
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.devops3-bg.id
        timeout           = "60s"
        auto_host_rewrite = false
      }
    }
  }

  authority = ["devops3.allegrohub.ru"]
}

resource "yandex_alb_load_balancer" "devops3-alb" {
  name               = "devops3-alb"
  network_id         = yandex_vpc_network.devops3-network.id
  security_group_ids = [yandex_vpc_security_group.devops3-sg-balancer.id]

  allocation_policy {
    location {
      zone_id   = var.yc_zone
      subnet_id = yandex_vpc_subnet.devops3-subnet.id
    }
  }

  listener {
    name = "devops3-listener-http"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.devops3-alb-ip.external_ipv4_address[0].address
        }
      }
      ports = [80]
    }
    http {
      redirects {
        http_to_https = true
      }
    }
  }

  listener {
    name = "devops3-listener-https"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.devops3-alb-ip.external_ipv4_address[0].address
        }
      }
      ports = [443]
    }
    tls {
      default_handler {
        http_handler {
          http_router_id = yandex_alb_http_router.devops3-router.id
        }
        certificate_ids = [yandex_cm_certificate.alb_cert.id]
      }
      sni_handler {
        name         = "devops3-sni"
        server_names = ["devops3.allegrohub.ru"]
        handler {
          http_handler {
            http_router_id = yandex_alb_http_router.devops3-router.id
          }
          certificate_ids = [yandex_cm_certificate.alb_cert.id]
        }
      }
    }
  }

  log_options {
    disable = true
  }
}
