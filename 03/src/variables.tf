###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_web" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_gb       = number
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    disk_gb       = 10
  }
  description = "Параметры web-ВМ (count)"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство образа для загрузочного диска"
}

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    { vm_name = "main", cpu = 2, ram = 2, disk_volume = 10 },
    { vm_name = "replica", cpu = 2, ram = 4, disk_volume = 15 }
  ]
  description = "Параметры ВМ баз данных (for_each)"
}