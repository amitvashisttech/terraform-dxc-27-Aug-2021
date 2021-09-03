```
  819  terraform plan -var="frontend_instance_count=1" -var="backend_instance_count=3"
  820  terraform plan -var="frontend_instance_count=3" -var="backend_instance_count=3"
  821  terraform plan -var="frontend_instance_count=3" -var="backend_instance_count=3" -out build-plan
  822  terraform plan
  823  cat variable.tf
  824  terraform show build-plan
  825  terraform apply  build-plan
  826  history
  827  terraform plan -destroy -var="frontend_instance_count=3" -var="backend_instance_count=3" -out destroy-plan
  828  terraform apply "destroy-plan"
```
