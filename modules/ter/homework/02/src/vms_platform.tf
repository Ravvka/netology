
variable "vm_web_ubuntu_family" {
    type = string
    default = "ubuntu-2004-lts"
}

variable "vm_web_platform_config" {
  type = object({
    platform_id   = string
    cores         = number
    memory        = number
    core_fraction = number
    preemptible   = bool
    nat           = bool
  })

  default = {
    platform_id   = "standard-v3"
    cores         = 2
    memory        = 1
    core_fraction = 20
    preemptible   = true
    nat           = true
  }
}

variable "vm_db_platform_config" {
  type = object({
    platform_id   = string
    zone          = string
    cores         = number
    memory        = number
    core_fraction = number
    preemptible   = bool
    nat           = bool
  })

  default = {
    platform_id   = "standard-v3"
    zone          = "ru-central1-b"
    cores         = 2
    memory        = 2
    core_fraction = 20
    preemptible   = true
    nat           = true
  }
}