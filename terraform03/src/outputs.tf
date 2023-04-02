output "all_vms" {
  description = "All VMs settings"
  value       = [
 {
  "name" = yandex_compute_instance.web[0].name
  "id"   = yandex_compute_instance.web[0].id
  "fqdn" = yandex_compute_instance.web[0].fqdn
 },
 {
  "name" = yandex_compute_instance.web[1].name
  "id"   = yandex_compute_instance.web[1].id
  "fqdn" = yandex_compute_instance.web[1].fqdn
 },
 {
  "name" = yandex_compute_instance.web2["vm1"].name
  "id"   = yandex_compute_instance.web2["vm1"].id
  "fqdn" = yandex_compute_instance.web2["vm1"].fqdn
 },
 {
  "name" = yandex_compute_instance.web2["vm2"].name
  "id"   = yandex_compute_instance.web2["vm2"].id
  "fqdn" = yandex_compute_instance.web2["vm2"].fqdn
 },
 {
  "name" = yandex_compute_instance.four_disks.name
  "id"   = yandex_compute_instance.four_disks.id
  "fqdn" = yandex_compute_instance.four_disks.fqdn
 }
]
}


