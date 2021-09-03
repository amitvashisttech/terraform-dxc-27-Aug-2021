module "instance" {
  source = "./modules/test-gcp"
}




module "frontend" {
  source = "./modules/gcp"
  environment-name = "frontend"
  total_instances = var.frontend_instance_count 
}



module "backend" {
  source = "./modules/gcp"
  environment-name = "backend"
  region = var.backend_region
  total_instances = var.backend_instance_count 
}
