resource "yandex_mdb_mysql_database" "db1" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "user1" {
  cluster_id = var.cluster_id
  name       = var.user_name
  password   = var.user_pass
  permission {
    database_name = yandex_mdb_mysql_database.db1.name
    roles         = ["ALL"]
  }
}