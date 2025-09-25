resource "yandex_vpc_network" "devops3-network" {
  name      = "devops3-network"
  folder_id = var.yc_folder_id
}

resource "yandex_vpc_subnet" "devops3-subnet" {
  name           = "devops3-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.devops3-network.id
  v4_cidr_blocks = ["192.168.0.0/24"]
  folder_id      = var.yc_folder_id
}

resource "yandex_vpc_address" "devops3-alb-ip" {
  name = "devops3-alb-ip"

  external_ipv4_address {
    zone_id = var.yc_zone
  }
}
