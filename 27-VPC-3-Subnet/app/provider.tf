provider "google" {
  project     = var.project
  credentials = file("/root/.ssh/account.json")
  region      = var.region
  zone        = var.zone
}

