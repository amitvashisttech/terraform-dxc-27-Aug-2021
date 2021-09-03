variable "environment-name" {
  default = "tfdemo"
}


variable "region" {
 default = "us-west1"
}

variable "total_instances" {
 default = "1"
}

variable "images" {
 type = map
 default = {
  us-west1 = "debian-cloud/debian-9"
  us-central1 = "centos-7"
  }
}

variable "project" {
  default = "deep-dynamics-324207"
}

locals {
  default_frontend_name = "${join("-",list(var.environment-name, "f"))}"
}
