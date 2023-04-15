
###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
### Database and user

variable "cluster_id" {
  type        = string
  default     = ""
  description = "Cluster id"
}

variable "db_name" {
  type        = string
  default     = ""
  description = "Database name"
}

variable "user_name" {
  type        = string
  default     = ""
  description = "Username"
}

variable "user_pass" {
  type        = string
  default     = ""
  description = "User password"
}