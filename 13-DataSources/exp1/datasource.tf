provider "google" {
  project     = "deep-dynamics-324207"
  credentials = file("/root/.ssh/account.json")
  region      = "us-west1"
}

data "google_compute_zones" "us-west1" {}

data "google_compute_image" "my_image" {
  family  = "debian-9"
  project = "debian-cloud"
}


variable "multi-region-deployment" {
  default = true
}

variable "environment-name" {
  default = "tfdemo"
}

locals {
  default_frontend_name = "${join("-",list(var.environment-name, "f"))}"
}


resource "google_compute_instance" "west_frontend" {
  #depends_on 		= [google_compute_instance.west_backend]
  name                  =  local.default_frontend_name
  count    		=  var.multi-region-deployment ? 3 : 0
  zone     		=  data.google_compute_zones.us-west1.names[count.index]
  machine_type 		= "f1-micro"
  

  boot_disk {
    initialize_params {
      image 		= data.google_compute_image.my_image.self_link
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network       	= "default"
    access_config {
    }
  }
}


output "data_scource_az" {
   value = data.google_compute_zones.us-west1.names
}
