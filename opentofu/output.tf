output "ip_nat_web" {
  description = "IP dinámica (NAT) del servidor web"
  value       = libvirt_domain.dominio_web.network_interface[0].addresses[0]
}

output "ip_datos_web" {
  description = "IP estática (Datos) del servidor web"
  value       = "10.10.10.11"
}

output "ip_nat_bd" {
  description = "IP dinámica (NAT) del servidor bd"
  value       = libvirt_domain.dominio_bd.network_interface[0].addresses[0]
}

output "ip_datos_bd" {
  description = "IP estática (Datos) del servidor bd"
  value       = "10.10.10.12"
}



output "ip_nat_docker" {
  description = "IP dinámica (NAT) del servidor Docker"
  value       = libvirt_domain.dominio_docker.network_interface[0].addresses[0]
}

output "ip_datos_docker" {
  description = "IP estática (Datos) del servidor Docker"
  value       = "10.10.10.13"
}
