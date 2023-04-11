module "mysql_cluster" {
  source     = "./mysql/cluster"
  name       = "example"
  network_id = module.vpc_dev.vpc_id
  ha         = true
  zone       = "ru-central1-a"
  subnet     = module.vpc_dev.subnet_id[0]
  token      = var.token
  cloud_id   = var.cloud_id
  folder_id  = var.folder_id
}

module "database" {
  source        = "./mysql/bd"
  cluster_id    = module.mysql_cluster.cluster_id
  db_name       = "test"
  user_name     = "app"
  user_pass     = "secret123"
  token         = var.token
  cloud_id      = var.cloud_id
  folder_id     = var.folder_id
}