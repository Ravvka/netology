resource "yandex_compute_disk" "shared_disks" {
  count = 3
  name  = "volume-${count.index}"
  type  = "network-hdd"
  zone  = var.default_zone
  size  = 1
}

resource "yandex_compute_instance" "storage" {
  name = "${local.vm_storage_name}"

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

  dynamic "secondary_disk" {
    for_each = toset(yandex_compute_disk.shared_disks[*].id)
    content {
      disk_id     = secondary_disk.value
      auto_delete = false
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
}
