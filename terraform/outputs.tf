output "postgresql_host" {
  value = yandex_mdb_postgresql_cluster.postgresql588.host[0].fqdn
}

output "app_server_1_ip" {
  value = yandex_compute_instance.app-server-1.network_interface.0.nat_ip_address
}

output "app_server_2_ip" {
  value = yandex_compute_instance.app-server-2.network_interface.0.nat_ip_address
}

output "alb_external_ip" {
  value = yandex_vpc_address.devops3-alb-ip.external_ipv4_address[0].address
}

output "datadog_monitor_url" {
  value = "https://app.datadoghq.eu/monitors/${datadog_monitor.HTTP_Check_Devops3.id}"
}
