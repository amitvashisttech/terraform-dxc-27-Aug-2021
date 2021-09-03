resource "google_storage_bucket" "amitvashist7-terraform-state" {
  name          = "amitvashist7-terraform-state-test-2"
  location      = var.location
  force_destroy = true
}
