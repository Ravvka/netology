###cloud vars
variable "vm_web_ubuntu_family" {
    type = string
    default = "ubuntu-2004-lts"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-e"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# variable "default_cidr" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

variable "subnet_cidrs" {
  type        = map(string)
  default     = {
      "ru-central1-b" = "10.1.0.0/24"
      "ru-central1-e" = "10.2.0.0/24"
  }
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "platform_id" {
  type = string
  default = "standard-v3"
}

###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   description = "ssh-keygen -t ed25519"
# }

variable "metadata" {
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJJ4pG5aPsAxAyOIq8xkpdwUjDmrWudo5CHjIF+pQico user@test.ru"
  }
}
