variable "libvirt_pool_name" {
  description = "Pool de almacenamiento de libvirt"
  type        = string
  default     = "default"
}

variable "base_image_debian" {
  description = "Imagen base para el servidor web"
  type        = string
  default     = "/var/lib/libvirt/images/debian13-base.qcow2"
}

variable "base_image_ubuntu" {
  description = "Imagen base para el servidor de base de datos"
  type        = string
  default     = "/var/lib/libvirt/images/ubuntu2604-base.qcow2"
}

variable "memory" {
  description = "Memoria RAM en MB para las VMs"
  type        = number
  default     = 1024
}
