variable "frontend_instance_count" {
  description = "Please provide the count for frontend Instances"
 }

variable "backend_instance_count" { 
  description = "Please provide the count for Backend Instances"
}


variable "backend_region" {
   default = "us-central1"
}
