data "yandex_compute_image" "ubuntu" {
  family = var.image_family 
}

resource "yandex_compute_instance" "web" {
  count      = 2                        
  name       = "web-${count.index + 1}" 
  depends_on = [yandex_compute_instance.db]

  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = var.vm_web.cores
    memory        = var.vm_web.memory
    core_fraction = var.vm_web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vm_web.disk_gb
    }
  }

  scheduling_policy {
    preemptible = true 
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true 
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_key}" 
  }
}
