resource "yandex_compute_instance" "web" {
  count = 2
  name = "netology-develop-platform-web-${count.index}"
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
  scheduling_policy {
    preemptible = var.vm_web_preemptible_settings
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
   # nat       = var.vm_web_nat_settings
    nat = false
  }

  metadata = {
    serial-port-enable = var.vm_metadata.serial_port_enable
    ssh-keys           = "${var.vm_metadata.ssh_user_name}:${local.path_to_ssh}"
  }

}