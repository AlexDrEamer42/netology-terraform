resource "yandex_compute_instance" "web2" {
  depends_on = [yandex_compute_instance.web ]
  platform_id = var.vm_web_platform_name
  for_each = var.params_for_each
  name = each.value.vm_name

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.vm_web_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu20.image_id
      size = each.value.disk
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible_settings
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat_settings
  }



  metadata = {
    serial-port-enable = var.vm_metadata.serial_port_enable
    ssh-keys           = "${var.vm_metadata.ssh_user_name}:${local.path_to_ssh}"
  }

}