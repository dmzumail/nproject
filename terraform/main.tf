# Настройка провайдера Yandex Cloud
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.90"
    }
  }
  required_version = ">= 1.0"
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

# Создаём публичную DNS-зону для твоего домена
resource "yandex_dns_zone" "public" {
  name        = "zone-${var.domain}"
  description = "Public DNS zone for ${var.domain}"
  zone        = "${var.domain}."
  public      = true
}

# Пример: A-запись на внешний IP (опционально, раскомментируй позже)
/*
resource "yandex_dns_recordset" "www" {
  zone_id = yandex_dns_zone.public.id
  name    = "www.${var.domain}."
  type    = "A"
  ttl     = 300
  data    = [var.public_ip]
}
*/