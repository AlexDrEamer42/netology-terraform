resource "yandex_compute_disk" "additional-disks" {
  count = 3
  name  = "netology-develop-disk-${count.index}"
  type  = "network-hdd"
  zone  = var.default_zone
  size  = 1
}

resource "yandex_compute_instance" "four_disks" {
  depends_on = [yandex_compute_disk.additional-disks]
  name = "netology-develop-platform-web-4discs"
  platform_id = var.vm_web_platform_name
  resources {
    cores         = var.vm_web_resources.cores
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu20.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.additional-disks
    content {
      disk_id  = lookup(secondary_disk.value, "id", null)

    }
  }


  scheduling_policy {
    preemptible = var.vm_web_preemptible_settings
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat_settings
    security_group_ids = [ yandex_vpc_security_group.example.id ]
  }

  metadata = {
    serial-port-enable = var.vm_metadata.serial_port_enable
    ssh-keys           = "${var.vm_metadata.ssh_user_name}:${local.path_to_ssh}"
  }

}

