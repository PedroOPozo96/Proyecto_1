# ==========================================
# SERVIDOR WEB (Debian)
# ==========================================

# 1. Volumen (Disco duro)
resource "libvirt_volume" "volumen_web" {
  name           = "volumen_web.qcow2"
  pool           = var.libvirt_pool_name
  base_volume_id = var.base_image_debian
  format         = "qcow2"
}

# 2. Disco Cloud-Init
resource "libvirt_cloudinit_disk" "cloudinit_web" {
  name           = "cloudinit_web.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-web.yaml")
  network_config = file("${path.module}/cloud-init/network-config-web.yaml")
}

# 3. Máquina Virtual (Dominio)
resource "libvirt_domain" "dominio_web" {
  name   = "servidor_web"
  memory = var.memory
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.volumen_web.id
  }
  cloudinit = libvirt_cloudinit_disk.cloudinit_web.id

  # ens3: Red NAT (DHCP)
  network_interface {
    network_id     = libvirt_network.red_nat.id
    wait_for_lease = true
  }

  # ens4: Red de Datos (Estática)
  network_interface {
    network_id = libvirt_network.red_datos.id
  }
}

# ==========================================
# SERVIDOR BASE DE DATOS (Ubuntu)
# ==========================================

# 1. Volumen (Disco duro)
resource "libvirt_volume" "volumen_bd" {
  name           = "volumen_bd.qcow2"
  pool           = var.libvirt_pool_name
  base_volume_id = var.base_image_ubuntu
  format         = "qcow2"
}

# 2. Disco Cloud-Init
resource "libvirt_cloudinit_disk" "cloudinit_bd" {
  name           = "cloudinit_bd.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-bd.yaml")
  network_config = file("${path.module}/cloud-init/network-config-bd.yaml")
}

# 3. Máquina Virtual (Dominio)
resource "libvirt_domain" "dominio_bd" {
  name   = "servidor_bd"
  memory = var.memory
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.volumen_bd.id
  }
  cloudinit = libvirt_cloudinit_disk.cloudinit_bd.id

  # ens3: Red NAT (DHCP)
  network_interface {
    network_id     = libvirt_network.red_nat.id
    wait_for_lease = true
  }

  # ens4: Red de Datos (Estática)
  network_interface {
    network_id = libvirt_network.red_datos.id
  }
}
