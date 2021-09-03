data "google_compute_zones" "avaliable" {}

resource "google_compute_instance" "west_frontend" {
  name 			= join("-", list(local.default_name, count.index))
  count                 =  lookup(var.instance_count, terraform.workspace)
  zone                  =  var.zone
  machine_type          =  lookup(var.instance_type, terraform.workspace)
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

