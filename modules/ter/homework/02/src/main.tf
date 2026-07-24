resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "develop" {
  for_each       = var.subnet_cidrs
  name           = "${var.vpc_name}-${each.key}"
  zone           = each.key
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [each.value]
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_ubuntu_family
}

resource "yandex_compute_instance" "platform_web" {
  name        = local.vm_web_name
  platform_id = var.platform_id
  zone        = var.vms_resources.web.zone
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.web.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop[var.vms_resources.web.zone].id
    nat       = var.vms_resources.web.nat
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }
}

resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name
  platform_id = var.platform_id
  zone        = var.vms_resources.db.zone
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.db.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop[var.vms_resources.db.zone].id
    nat       = var.vms_resources.db.nat
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }

}
