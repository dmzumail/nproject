
#output "dns_name_servers" {
#  description = "Name servers to set at your domain registrar"
#  value       = yandex_dns_zone.public.name_servers
#}


output "zone_id" {
  description = "ID of created DNS zone"
  value       = yandex_dns_zone.public.id
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = yandex_compute_instance.web.network_interface.0.nat_ip_address
}

output "vm_id" {
  description = "ID of the created VM"
  value       = yandex_compute_instance.web.id
}