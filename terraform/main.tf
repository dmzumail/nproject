# Создаём публичную DNS-зону
resource "yandex_dns_zone" "public" {
  name        = "zone-${replace(var.domain, ".", "-")}"
  description = "Public DNS zone for ${var.domain}"
  zone        = "${var.domain}."
  public      = true
}

# Получаем актуальный образ Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

# Security group для веб-сервера
resource "yandex_vpc_security_group" "web" {
  name        = "sg-web-${replace(var.domain, ".", "-")}"
  network_id  = yandex_vpc_network.default.id

  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# ВМ с автоматическим HTTPS через Let's Encrypt
resource "yandex_compute_instance" "web" {
  name        = "vm-${replace(var.domain, ".", "-")}"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.default.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.web.id]
  }

  metadata = {
    ssh-keys = var.ssh_public_key != "" ? "ubuntu:${var.ssh_public_key}" : ""
    user-data = templatefile("${path.module}/cloud-init.yaml.tftpl", { domain = var.domain })
  }

  allow_stopping_for_update = true
}

# A-запись для корня домена
resource "yandex_dns_recordset" "site" {
  zone_id = yandex_dns_zone.public.id
  name    = "${var.domain}."
  type    = "A"
  ttl     = 300
  data    = [yandex_compute_instance.web.network_interface[0].nat_ip_address]

  depends_on = [yandex_compute_instance.web]
}

# A-запись для www
resource "yandex_dns_recordset" "www" {
  zone_id = yandex_dns_zone.public.id
  name    = "www.${var.domain}."
  type    = "A"
  ttl     = 300
  data    = [yandex_compute_instance.web.network_interface[0].nat_ip_address]

  depends_on = [yandex_compute_instance.web]
}