variable "images" {
  type = "map"
  default = {
    us-west1 = "debian-cloud/debian-9"
    us-central1 = "centos-6"
  }
}


variable "total_instances" {
  default=1
}

variable "environment-name" {
  default = "tfdemo"
}

variable "name" {
  description = "VPC Name"
  default = "mytestvpc"
}

variable "auto_create_subnetworks" {
  default     = "true"
  description = "false = creates custom VPC, true = automatically creates subnets in each region"
}

variable "region" {
 default = "us-west1"
}


variable "zone" {
 default = "us-west1-a"
}

variable "location" {
 default = "US"
}

variable "project" {
  default = "deep-dynamics-324207"
}
