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
  name        = var.vm_web_platform_config.name
  platform_id = var.vm_web_platform_config.platform_id
  zone        = var.default_zone
  resources {
    cores         = var.vm_web_platform_config.cores
    memory        = var.vm_web_platform_config.memory
    core_fraction = var.vm_web_platform_config.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_platform_config.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop["ru-central1-e"].id
    nat       = var.vm_web_platform_config.nat
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}

resource "yandex_compute_instance" "platform_db" {
  name        = var.vm_db_platform_config.name
  platform_id = var.vm_db_platform_config.platform_id
  zone        = var.vm_db_platform_config.zone
  resources {
    cores         = var.vm_db_platform_config.cores
    memory        = var.vm_db_platform_config.memory
    core_fraction = var.vm_db_platform_config.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_platform_config.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop["ru-central1-b"].id
    nat       = var.vm_db_platform_config.nat
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
