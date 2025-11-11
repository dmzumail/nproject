output "dns_name_servers" {
  description = "Name servers to set at your domain registrar"
  value       = yandex_dns_zone.public.name_servers
}

output "zone_id" {
  description = "ID of created DNS zone"
  value       = yandex_dns_zone.public.id
}