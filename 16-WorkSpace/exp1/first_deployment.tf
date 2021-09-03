#########GCP##########
provider "google" {
  credentials = file("/root/.ssh/account.json")
  project     = "deep-dynamics-324207"
  region      = "us-central1"
  zone        = "us-central1-c"
}

locals {
  default_name = "${join("-", list(terraform.workspace, "example"))}"
}

resource "google_compute_instance" "vm_instance" {
  name         = local.default_name
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}
