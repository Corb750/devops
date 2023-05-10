# Определение переменных
variable "yc_token" {}
variable "yc_cloud_id" {}
variable "yc_folder_id" {}

# Настройки облачного провайдера
provider "yandex" {
  token        = var.yc_token
  cloud_id     = var.yc_cloud_id
  folder_id    = var.yc_folder_id
  zone         = "ru-central1-a"
  endpoint     = "https://compute.api.cloud.yandex.net"
}

# Создание виртуальной машины для Kubernetes мастера
resource "yandex_compute_instance" "kubernetes_master" {
  name = "kubernetes-master"

  boot_disk {
    initialize_params {
      image_id = "fd8tmnt5a5vmqnv3q8bs"
    }
  }

  resources {
    cores  = 2
    memory = 4
  }

  network_interface {
    subnet_id = "subnet-XXXXXXXXXXXXXXXXXXXXXXXXXX"
  }

  metadata = {
    "user-data" = filebase64("${path.module}/userdata/master.sh")
  }
}

# Создание виртуальной машины для Kubernetes приложения
resource "yandex_compute_instance" "kubernetes_app" {
  name = "kubernetes-app"

  boot_disk {
    initialize_params {
      image_id = "fd8tmnt5a5vmqnv3q8bs"
    }
  }

  resources {
    cores  = 2
    memory = 4
  }

  network_interface {
    subnet_id = "subnet-XXXXXXXXXXXXXXXXXXXXXXXXXX"
  }

  metadata = {
    "user-data" = filebase64("${path.module}/userdata/app.sh")
  }
}

# Создание виртуальной машины для служебного сервера
resource "yandex_compute_instance" "service_server" {
  name = "service-server"

  boot_disk {
    initialize_params {
      image_id = "fd8tmnt5a5vmqnv3q8bs"
    }
  }

  resources {
    cores  = 2
    memory = 4
  }

  network_interface {
    subnet_id = "subnet-XXXXXXXXXXXXXXXXXXXXXXXXXX"
  }

  metadata = {
    "user-data" = filebase64("${path.module}/userdata/service.sh")
  }
}
