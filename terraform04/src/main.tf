module "vpc_dev" {
  source       = "./vpc"
  env_network_name     = "develop net"
  env_subnet_name     = "develop subnet"
  subnets = [
    { zone = "ru-central1-a", cidr = ["10.0.1.0/24"] },
    { zone = "ru-central1-b", cidr = ["10.0.2.0/24"] },
    { zone = "ru-central1-c", cidr = ["10.0.3.0/24"] },
  ]
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

module "test-vm" {
  depends_on      = [module.vpc_dev]
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_dev.vpc_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [ module.vpc_dev.subnet_id[0] ]
  instance_name   = "web"
  instance_count  = 1
  image_family    = "ubuntu-2004-lts"
  public_ip       = true

  metadata = {
      user-data          = data.template_file.cloud-init.rendered
      serial-port-enable = 1
  }

}

data template_file "cloud-init" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = local.path_to_ssh
  }
}

