#########GCP##########
provider "google" {
  credentials = file("/root/.ssh/account.json")
  project     = "deep-dynamics-324207"
  region      = "us-west1"
}


variable "zones" {
  default = ["us-west1-a", "us-west1-b"]
}

resource "google_compute_instance" "frontend" {
  name         = "frontend-${count.index}"
  machine_type = "f1-micro"
  count        = 2
  zone         = var.zones[count.index]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}

