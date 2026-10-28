resource "libvirt_network" "red_nat" {
  name      = "red_nat_proyecto"
  mode      = "nat"
  addresses = ["192.168.101.0/24"]
}

resource "libvirt_network" "red_datos" {
  name = "red_datos_proyecto"
  mode = "none"
}
