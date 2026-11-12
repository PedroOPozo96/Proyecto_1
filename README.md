# Proyecto Intermodular ASIR — OpenTofu y Ansible

## Descripción

Este proyecto tiene como objetivo desplegar y configurar automáticamente una infraestructura de servidores virtualizados utilizando **OpenTofu, Ansible y libvirt/KVM**.

La infraestructura inicial está formada por un servidor web con Apache y PHP y un servidor de base de datos MariaDB que permite el funcionamiento de la aplicación Guestbook.

En la primera modificación se ha incorporado un tercer servidor con Docker y Portainer para gestionar contenedores.

## Infraestructura

| Máquina | Sistema operativo | Función | IP de datos |
|---|---|---|---|
| servidor_web | Debian 13 | Apache, PHP y Guestbook | 10.10.10.11 |
| servidor_bd | Ubuntu 26.04 | MariaDB | 10.10.10.12 |
| servidor_docker | Debian 13 | Docker y Portainer | 10.10.10.13 |

Todas las máquinas utilizan dos interfaces de red:

- **Red NAT:** permite el acceso por SSH y la conexión a Internet mediante DHCP.
- **Red de datos:** permite la comunicación interna entre los servidores mediante IP estática.

## Tecnologías utilizadas

- OpenTofu para gestionar la infraestructura.
- Virt-Manager y libvirt/KVM para la virtualización.
- Cloud-init para la configuración inicial de las máquinas.
- Ansible para automatizar la configuración.
- Apache, PHP y MariaDB para Guestbook.
- Docker para ejecutar contenedores.
- Portainer para administrar el entorno Docker.

## Estructura del repositorio

**opentofu/**

Contiene los archivos de configuración de la infraestructura, redes, variables, outputs, inventario y configuraciones Cloud-init.

**ansible/**

Contiene el inventario generado automáticamente, las variables, el playbook principal y los siguientes roles:

- `commons`: configuración común.
- `web`: servidor Apache y PHP.
- `bd`: servidor MariaDB.
- `docker`: instalación y activación de Docker.
- `portainer`: despliegue de Portainer con almacenamiento persistente.

## Requisitos previos

Para ejecutar el proyecto se necesita:

- Un equipo con libvirt/KVM configurado.
- OpenTofu y Ansible instalados.
- Acceso a las imágenes base de Debian 13 y Ubuntu 26.04.
- Una clave SSH compatible con las configuraciones Cloud-init.
- Las colecciones de Ansible `community.mysql` y `community.docker`.

Las colecciones pueden instalarse mediante:

`ansible-galaxy collection install community.mysql community.docker`

## Despliegue

### 1. Crear la infraestructura

Desde el directorio `opentofu/`:

`tofu init`

`tofu apply`

OpenTofu crea las máquinas virtuales y genera automáticamente el inventario `ansible/hosts` utilizando las direcciones IP de la red NAT.

El comando `tofu init` solo es necesario al inicializar el entorno o cuando cambian sus dependencias.

### 2. Configurar los servidores

Desde el directorio `ansible/`:

`ansible-playbook site.yaml`

Ansible utiliza el inventario generado por OpenTofu para conectarse mediante SSH a las máquinas y aplicar sus roles.

Una segunda ejecución permite comprobar la idempotencia de la configuración.

## Acceso a Portainer

Una vez desplegado el servidor Docker, puede accederse a Portainer mediante:

`https://IP_NAT_DOCKER:9443`

La dirección IP se obtiene ejecutando desde `opentofu/`:

`tofu output -raw ip_nat_docker`

Portainer utiliza HTTPS con un certificado autofirmado.

**Nota:** la creación inicial del administrador se ha realizado manualmente mediante el asistente web y un token de configuración. La instalación del contenedor está automatizada, pero esta inicialización sigue requiriendo intervención manual.

## Eliminación de la infraestructura

Desde el directorio `opentofu/`:

`tofu destroy`

Este comando elimina los recursos gestionados por OpenTofu. Debe utilizarse con precaución, ya que puede eliminar los discos y datos de las máquinas desplegadas.

## Repositorio

[Consultar historial de commits en GitHub](https://github.com/PedroOPozo96/Proyecto_1/commits/main/)
