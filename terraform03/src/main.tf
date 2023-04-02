resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu20" {
  family = var.family_name
}

data "yandex_compute_image" "ubuntu22" {
  family = var.family_name2
}

# Ansible

resource "local_file" "hosts1_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = {
      (yandex_compute_instance.web[0].name) = (yandex_compute_instance.web[0].network_interface[0].nat_ip_address != "" ? yandex_compute_instance.web[0].network_interface[0].nat_ip_address : yandex_compute_instance.web[0].network_interface[0].ip_address),
      (yandex_compute_instance.web[1].name) = (yandex_compute_instance.web[1].network_interface[0].nat_ip_address != "" ? yandex_compute_instance.web[1].network_interface[0].nat_ip_address : yandex_compute_instance.web[1].network_interface[0].ip_address),
      (yandex_compute_instance.web2["vm1"].name) = (yandex_compute_instance.web2["vm1"].network_interface[0].nat_ip_address != "" ? yandex_compute_instance.web2["vm1"].network_interface[0].nat_ip_address : yandex_compute_instance.web["vm1"].network_interface[0].ip_address),
      (yandex_compute_instance.web2["vm2"].name) = (yandex_compute_instance.web2["vm2"].network_interface[0].nat_ip_address != "" ? yandex_compute_instance.web2["vm2"].network_interface[0].nat_ip_address : yandex_compute_instance.web["vm2"].network_interface[0].ip_address)
      }
    }
  )

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "null_resource" "web_hosts_provision" {
#Ждем создания инстанса
depends_on = [yandex_compute_instance.web, yandex_compute_instance.web2, yandex_compute_instance.four_disks]

#Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_rsa | ssh-add -"
  }

#Костыль!!! Даем ВМ время на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
 provisioner "local-exec" {
    command = "sleep 30"
  }

#Запуск ansible-playbook
  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
    triggers = {
      always_run         = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
      playbook_src_hash  = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
      ssh_public_key     = local.path_to_ssh # при изменении переменной
    }

}