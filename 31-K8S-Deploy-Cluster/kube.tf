module "kubernetes" {
  source = "./kubernetes"
  region = "us-east1"

  project_id_map = {
    default = "deep-dynamics-324207"
  }
}

output "connection-command" {
  value = "${module.kubernetes.connect-string}"
}
