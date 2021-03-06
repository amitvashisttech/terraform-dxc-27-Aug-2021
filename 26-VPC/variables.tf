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
