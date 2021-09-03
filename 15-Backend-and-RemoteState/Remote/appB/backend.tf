terraform {
   backend "gcs" {
     bucket = "amitvashist7-terraform-state"
     prefix = "terraform/appB"
     credentials = "/root/.ssh/account.json"
  }
}
