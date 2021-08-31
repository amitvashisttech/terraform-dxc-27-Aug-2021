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

variable "us-west-zones" {
  default = ["us-west1-a", "us-west1-b"]
}

variable "us-central-zones" {
  default = ["us-central1-a", "us-central1-b"]
}

variable "multi-region-deployment" {
  default = true
}

variable "environment-name" {
  default = "myfirstproject"
}


variable "environment-name-2" {
  default = "mysecondproject"
}

locals {
  default_frontend_name = "${join("-",list(var.environment-name, "frontend"))}"
  default_backend_name  = "${join("-",list(var.environment-name, "backend"))}"
  default_frontendwest_name = "${join("-",list(var.environment-name-2, "f"))}"
  default_backendwest_name  = "${join("-",list(var.environment-name-2, "b"))}"
}


resource "google_compute_instance" "west_frontend" {
  depends_on 		= [google_compute_instance.west_backend]
  #name     		= "${join("-", list(var.project-name, "west-frontend" ))}-${count.index + 1}"
  name                  =  local.default_frontendwest_name
  count    		=  var.multi-region-deployment ? 1 : 0
  zone     		=  var.us-west-zones[count.index]
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
  zone     		= var.us-central-zones[count.index]
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
  zone     			= var.us-central-zones[count.index]
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
  zone     			=  var.us-west-zones[count.index]
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
