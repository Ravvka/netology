resource "yandex_compute_instance" "count_db" {
  count = 2
  name = "${local.vm_db_name}-${var.each_vm[count.index].name}"

  platform_id = var.platform_id
  zone        = var.default_zone
  resources {
    cores         = var.each_vm[count.index].cores
    memory        = var.each_vm[count.index].memory
    core_fraction = var.each_vm[count.index].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.each_vm[count.index].disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.each_vm[count.index].preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.each_vm[count.index].nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.each_vm[count.index].user}:${local.pub_ssh_key}"
  }
}
