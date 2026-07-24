variable "vms_resources" {
  default = {
    web = {
       cores         = 2
       memory        = 1
       core_fraction = 20
       zone          = "ru-central1-e"
       preemptible   = true
       nat           = true
    },
    db = {
       cores         = 2
       memory        = 2
       core_fraction = 20
       zone          = "ru-central1-b"
       preemptible   = true
       nat           = true
    }
  }
}
