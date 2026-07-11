resource "local_file" "inventory" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web        # count -> уже список
    databases  = values(yandex_compute_instance.db) # for_each map -> список через values()
    storage    = [yandex_compute_instance.storage]  # один объект -> оборачиваем в список
  })
  filename = "${abspath(path.module)}/hosts.ini"
}