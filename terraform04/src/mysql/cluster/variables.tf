
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
### Cluster settings

variable "name" {
  type = string
  description = "Cluster name"
}

variable "network_id" {
  type = string
  description = "Cluster network id"
}

variable "ha" {
  type = bool
  description = "Enable HA?"
}

variable "mysql_version" {
  type = string
  default = "8.0"
  description = "MySQL version"
}

variable "environment" {
  type = string
  default = "PRESTABLE"
  description = "Environment type"
}

variable "del_protect" {
  type = bool
  default = false
  description = "Deletion protection?"
}

variable "security_groups" {
  type = list(string)
  default = []
  description = "Security groups ids"
}

variable "host_class" {
  type = string
  default = "s1.micro"
  description = "Host class"
}

variable "disk_type" {
  type = string
  default = "network-hdd"
  description = "Disks type"
}

variable "disk_size" {
  type = number
  default = 10
  description = "Storage size"
}

variable "zone" {
  type = string
  description = "Zone"
}

variable "subnet" {
  type = string
  description = "Subnet id"
}

