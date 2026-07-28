data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "time_sleep" "wait" {
  create_duration = "60s" # ждём 60 секунд после создания первого экземпляра
}

resource "yandex_compute_instance" "count_web" {
  count = 2
  name = "netology-develop-platform-web-${count.index + 1}"

  platform_id = var.platform_id
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources.cores
    memory        = var.vms_resources.memory
    core_fraction = var.vms_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.nat
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.public_ssh_key}"
  }

  depends_on = [
    time_sleep.wait
  ]

  timeouts {
    create = "5m"
  }
}
