###company vars
variable "company" {
  type = string
  default = "netology"
}

variable "stand" {
  type = string
  default = "develop"
}

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

variable "image_family" {
    type = string
    default = "ubuntu-2004-lts"
}

variable "platform_id" {
  type = string
  default = "standard-v3"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vms_resources" {
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
    preemptible   = true
    nat           = false
    user          = "ubuntu"
  }
}

variable "each_vm" {
  type    = list(object({
                    name          = string,
                    cores         = number,
                    memory        = number,
                    core_fraction = number,
                    disk_volume   = number,
                    preemptible   = bool,
                    nat           = bool,
                    user          = string
                  }))
  default = [
      {
        name       = "main"
        cores         = 4
        memory        = 2
        core_fraction = 20
        disk_volume   = 10
        preemptible   = true
        nat           = false
        user          = "db_user"
      },
      {
        name       = "replica"
        cores         = 2
        memory        = 1
        core_fraction = 20
        disk_volume   = 5
        preemptible   = true
        nat           = false
        user          = "db_user"
      }

    ]
}

# ssh
variable "home_path" {
  type        = string
  description = "User home dir full path"
}

variable "public_ssh_key" {
  type        = string
  description = "Публичный SSH-ключ для доступа к ВМ"
}