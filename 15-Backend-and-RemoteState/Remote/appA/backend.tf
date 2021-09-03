terraform {
   backend "gcs" {
     bucket = "amitvashist7-terraform-state"
     prefix = "terraform/appA"
     credentials = "/root/.ssh/account.json"
  }
}
