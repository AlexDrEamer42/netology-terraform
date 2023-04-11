output "vpc_id" {
  description = "Network id"
  value = yandex_vpc_network.develop.id
}

output "subnet_id" {
  description = "Subnet id"
  value = [for instance in yandex_vpc_subnet.develop: instance.id]
}