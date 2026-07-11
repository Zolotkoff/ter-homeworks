resource "yandex_compute_disk" "data" {
  count = 3
  name  = "disk-${count.index + 1}" # disk-1, disk-2, disk-3
  zone  = var.default_zone
  size  = 1
}


resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.data[*].id 
    content {
      disk_id = secondary_disk.value
    }
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