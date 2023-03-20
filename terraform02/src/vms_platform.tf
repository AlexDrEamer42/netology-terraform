# compute instance vars

# vm_web

variable "vm_web_platform_name" {
  type         = string
  default      = "standard-v1"
  description  = "Platform name"
}

variable "vm_web_resources" {
  type = map
  default = {
  cores = 2
  memory = 1
  core_fraction = 5
  }
  description = "VM resources"
}

variable "vm_web_preemptible_settings" {
  type         = bool
  default      = true
  description  = "Is compute instance preemptible?"
}

variable "vm_web_nat_settings" {
  type         = bool
  default      = true
  description  = "Use NAT?"
}

# vm_db

variable "vm_db_platform_name" {
  type         = string
  default      = "standard-v1"
  description  = "Platform name"
}

variable "vm_db_resources" {
  type = map
  default = {
  cores = 2
  memory = 2
  core_fraction = 20
  }
  description = "VM resources"
}

variable "vm_db_preemptible_settings" {
  type         = bool
  default      = true
  description  = "Is compute instance preemptible?"
}

variable "vm_db_nat_settings" {
  type         = bool
  default      = true
  description  = "Use NAT?"
}

# metadata

variable "vm_metadata" {
  type = map
  default = {
  serial_port_enable = 1
  ssh_user_name = "ubuntu"
  ssh_root_key = "<my_ssh_key_is_here>"
  }
  description = "VM metadata"
}
