terraform {
   backend "gcs" {
     bucket = "amitvashist7-terraform-state"
     prefix = "terraform/wordspace"
     credentials = "/root/.ssh/account.json"
  }
}
