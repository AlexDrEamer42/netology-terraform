resource "yandex_vpc_network" "develop" {
  name = var.env_network_name
}

resource "yandex_vpc_subnet" "develop" {
   depends_on = [yandex_vpc_network.develop]
   for_each = {for z, c in var.subnets: z => c}
   name = "${var.env_subnet_name}-${each.value.zone}"
   network_id     = yandex_vpc_network.develop.id
   zone = each.value.zone
   v4_cidr_blocks = each.value.cidr
}

