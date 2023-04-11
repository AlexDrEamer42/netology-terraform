resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  # count               = var.ha ? 1 : 0
  name                = var.name
  environment         = var.environment
  network_id          = var.network_id
  version             = var.mysql_version
  security_group_ids  = var.security_groups
  deletion_protection = var.del_protect

  resources {
    resource_preset_id = var.host_class
    disk_type_id       = var.disk_type
    disk_size          = var.disk_size
  }

  host {
    zone      = var.zone
    subnet_id = var.subnet
  }

  dynamic "host" {
   for_each = ( var.ha ? [1] : [] )
    content {
      zone      = var.zone
      subnet_id = var.subnet
    }
  }

  dynamic "host" {
   for_each = ( var.ha ? [1] : [] )
    content {
      zone      = var.zone
      subnet_id = var.subnet
    }
  }

}

