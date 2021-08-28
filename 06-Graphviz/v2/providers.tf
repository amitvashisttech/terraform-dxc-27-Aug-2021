#########GCP##########
provider "google" {
  credentials = file("/root/.ssh/account.json")
  project     = "deep-dynamics-324207"
  region      = "us-west1"
  zone        = "us-west1-c"
}


provider "google" {
  credentials = file("/root/.ssh/account.json")
  project     = "deep-dynamics-324207"
  region      = "us-central1"
  zone        = "us-central1-a"
  alias       = "myregion"
}


resource "google_compute_instance" "frontend" {
  name         = "frontend"
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



resource "google_compute_instance" "backend" {
   
  provider      = google.myregion
  name         = "backend"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}




