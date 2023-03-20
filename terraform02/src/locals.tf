locals {
  org = "netology"
  env = "develop"
  project = "platform"
  web_role = "web"
  db_role = "db"
  vm_db_instance_name = "${local.org}-${local.env}-${local.project}-${local.db_role}"
  vm_web_instance_name = "${local.org}-${local.env}-${local.project}-${local.web_role}"
}