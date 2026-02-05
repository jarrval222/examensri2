# Infraestructura de Servicios en Red - Javier Arrabal

Este proyecto despliega una infraestructura completa de servicios de red mediante **Docker Compose**, utilizando contenedores basados en Debian y soluciones específicas para correo y DNS.

## 🚀 Servicios Desplegados

### 1. Servidor Debian (`srv_javier`)

* **Apache2 (Web):** Servidor con soporte **HTTPS** mediante un certificado digital para `*.javierarrabal.test`. Incluye una zona restringida en `/admin` protegida por autenticación de usuarios y grupos.
* **Bind9 (DNS):** Gestiona la zona `javierarrabal.test`, proporcionando resolución para los servicios web, FTP y registros MX para el correo.
* **vsftpd (FTP):** Servidor de transferencia de archivos con configuración de **usuarios virtuales** y medidas de seguridad como el enjaulamiento (`chroot`) para aislar a los usuarios en sus directorios.

### 2. Servidor de Correo (Poste.io)

* **Poste.io:** Solución integral de correo electrónico configurada con el hostname `mail.javierarrabal.test`.
* **Gestión de Usuarios:** Cuentas creadas para `webmaster` y `arturo` con una **cuota de disco de 1024 MB (1GB)** cada una.
* **Webmail:** Interfaz accesible para el envío y recepción de correos entre usuarios del dominio.

## 🛠️ Configuración y Resiliencia (Punto 6.4)

El sistema está diseñado para ser autogestionado tras un reinicio. Se ha implementado un script de provisión denominado `provision.sh` que realiza las siguientes acciones automáticamente al arrancar el contenedor:

1. Inicia el servicio de nombres **Bind9**.
2. Inicia el servidor **vsftpd**.
3. Activa los módulos de seguridad de **Apache** y lanza el servicio web en primer plano.

Esto garantiza que todos los servicios sean operativos inmediatamente después de un `docker restart` o una caída del sistema.

## 🔒 Seguridad Implementada

* **Cifrado:** Navegación segura mediante TLS/SSL.
* **Control de Acceso:** Restricción por grupos en el servidor web mediante el módulo `authz_groupfile`.
* **Seguridad FTP:** Los usuarios virtuales están limitados a su directorio raíz para evitar accesos no autorizados al sistema de archivos del servidor.
* **Cuotas de Correo:** Limitación de almacenamiento a 1GB para asegurar la estabilidad del servidor.

## 📁 Estructura del Proyecto

* `/apache`: Configuraciones de sitios y archivos de contraseñas (`.htpasswd`).
* `/bind`: Archivos de zona y configuración del DNS.
* `/certs`: Certificados SSL generados.
* `/vsftpd`: Configuración del servidor FTP y usuarios.
* `docker-compose.yml`: Orquestador de los contenedores.
* `provision.sh`: Script de automatización de arranque.

## 🏁 Instrucciones de Uso

1. Clonar el repositorio.
2. Desplegar la infraestructura:

   ```bash
   docker-compose up -d
