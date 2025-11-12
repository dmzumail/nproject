# Создаём сеть и подсеть
resource "yandex_vpc_network" "default" {
  name = "net-${replace(var.domain, ".", "-")}"
}

resource "yandex_vpc_subnet" "default" {
  name       = "subnet-${replace(var.domain, ".", "-")}"
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}