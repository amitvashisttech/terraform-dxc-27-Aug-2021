provider "google" {
  project     = "deep-dynamics-324207"
  credentials = file("/root/.ssh/account.json")
  region      = "us-west1"
}

provider "google" {
  credentials =  file("/root/.ssh/account.json")
  project     = "deep-dynamics-324207"
  region      = "us-central1"
  alias       = "myregion"
}

/*
variable "us-west-zones" {
  default = ["us-west1-a", "us-west1-b"]
}

variable "us-central-zones" {
  default = ["us-central1-a", "us-central1-b"]
}
*/

data "google_compute_zones" "us-west1" {}

data "google_compute_zones" "us-central1" {
     provider = google.myregion
}



variable "multi-region-deployment" {
  default = true
}

variable "environment-name" {
  default = "tfdemo"
}


variable "environment-name-2" {
  default = "tfdemo-2"
}

locals {
  default_frontend_name = "${join("-",list(var.environment-name, "f"))}"
  default_backend_name  = "${join("-",list(var.environment-name, "b"))}"
  default_frontendwest_name = "${join("-",list(var.environment-name-2, "f"))}"
  default_backendwest_name  = "${join("-",list(var.environment-name-2, "b"))}"
}

locals {
   az_west =  data.google_compute_zones.us-west1.names
}

resource "google_compute_instance" "west_frontend" {
  depends_on 		= [google_compute_instance.west_backend]
  #name     		= "${join("-", list(var.project-name, "west-frontend" ))}-${count.index + 1}"
  name                  =  local.default_frontendwest_name
  count    		=  var.multi-region-deployment ? 2 : 0
  #zone     		=  var.us-west-zones[count.index]
  zone     		=  local.az_west[count.index]
  machine_type 		= "f1-micro"
  boot_disk {
    initialize_params {
      image 		= "debian-cloud/debian-9"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network       	= "default"
    access_config {
    }
  }
}

resource "google_compute_instance" "frontend" {
  provider      	= google.myregion
  name                  =  local.default_frontend_name
  #name     		= "${join("-", list(var.project-name, "frontend" ))}-${count.index + 1}"
  depends_on 		= [google_compute_instance.backend]
  count    		= 1
  #zone     		= var.us-central-zones[count.index]
  zone     		=  data.google_compute_zones.us-central1.names[count.index]
  machine_type 		= "f1-micro"
  boot_disk {
    initialize_params {
      image 		= "debian-cloud/debian-9"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network    		 = "default"
    access_config {
    }
  }
}


resource "google_compute_instance" "backend" {
  provider      		= google.myregion
  #name     		        = "${join("-", list(var.project-name, "backend" ))}-${count.index + 1}"
  name                  =  local.default_backend_name
  machine_type 			= "f1-micro"
  count                 	= 1
  #zone     			= var.us-central-zones[count.index]
  zone     		=  data.google_compute_zones.us-central1.names[count.index]
  boot_disk {
    initialize_params {
      image 			= "debian-cloud/debian-9"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network       		= "default"
    access_config {
    }
  }
  lifecycle {
    prevent_destroy = false
  }
}


resource "google_compute_instance" "west_backend" {
  machine_type 			= "f1-micro"
  name                  =   local.default_backendwest_name
  #name     		        = "${join("-", list(var.project-name, "west-backend" ))}-${count.index + 1}"
  count    		        =  var.multi-region-deployment ? 1 : 0 
  #zone     			=  var.us-west-zones[count.index]
  zone     		=  data.google_compute_zones.us-west1.names[count.index]
  boot_disk {
    initialize_params {
      image 			= "debian-cloud/debian-9"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network       		= "default"
    access_config {
    }
  }
  lifecycle {
    prevent_destroy = false
  }
}


#output "backend_ips" {
#  value = "${list ("${google_compute_instance.backend[*].network_interface[0].access_config[0].nat_ip}","${google_compute_instance.backend[*].network_interface[0].network_ip}")}"
#}
