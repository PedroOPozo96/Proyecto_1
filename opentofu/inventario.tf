resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventario.tftpl", {
    ip_web = libvirt_domain.dominio_web.network_interface[0].addresses[0]
    ip_bd  = libvirt_domain.dominio_bd.network_interface[0].addresses[0]
  })
  filename = "${path.module}/../ansible/hosts"
}
