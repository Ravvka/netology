resource "yandex_compute_instance" "each_db" {
  for_each = { for vm in var.each_vm : vm.name => vm }

  name = "${local.vm_db_name}-${each.value.name}"
  platform_id = var.platform_id
  zone        = var.default_zone
  
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = each.value.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${each.value.user}:${local.pub_ssh_key}"
  }
}
