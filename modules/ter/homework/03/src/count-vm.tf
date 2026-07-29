resource "yandex_compute_instance" "count_web" {
  count = 2
  name = "${local.vm_web_name}-${count.index + 1}"

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
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vms_resources.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.vms_resources.user}:${var.public_ssh_key}"
  }

  depends_on = [
    yandex_compute_instance.count_db
  ]
}
