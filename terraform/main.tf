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