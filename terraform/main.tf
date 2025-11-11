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

# Создаём DNS-зону для домена
resource "yandex_dns_zone" "main" {
  name        = "zone-${var.domain}"
  description = "Managed zone for ${var.domain}"
  zone       = "${var.domain}."
  public      = true
}