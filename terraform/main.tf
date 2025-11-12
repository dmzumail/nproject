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
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    user-data = "#cloud-config\npackages:\n  - nginx\nruncmd:\n  - echo '<h1>Hello from Yandex Cloud!</h1>' > /var/www/html/index.html"
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