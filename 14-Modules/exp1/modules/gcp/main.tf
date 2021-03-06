data "google_compute_zones" "avaliable" {}

resource "google_compute_instance" "west_frontend" {
  name                  =  local.default_frontend_name
  count                 =  var.total_instances
  zone                  =  data.google_compute_zones.avaliable.names[count.index]
  machine_type          = "f1-micro"
  boot_disk {
    initialize_params {
      image             = var.images[var.region]
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network             = "default"
    access_config {
    }
  }
}

