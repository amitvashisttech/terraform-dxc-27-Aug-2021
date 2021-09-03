variable "environment-name" {
  default = "tfdemo"
}


variable "region" {
 default = "us-west1"
}


variable "zone" {
 default = "us-west1-a"
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

variable "instance_type" {
  type = map
  default = {
      default = "f1-micro"
      dev     = "e2-small"
      prod     = "e2-medium"
      dxc    = "e2-standard-2"

  }

}



variable "instance_count" {
  type = map
  default = {
      default = "1"
      dev     = "2"
      prod    = "5"
      dxc     = "7"
  }

}

locals {
  default_name = "${join("-", list(terraform.workspace, "example"))}"
}



variable "key_name" {
  default = "~/.ssh/id_rsa.pub"
}

variable "pvt_key" {
  default = "~/.ssh/id_rsa"
}
