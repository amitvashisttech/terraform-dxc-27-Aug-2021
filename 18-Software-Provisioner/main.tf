resource "google_compute_instance" "vm_instance" {
  name         = "default"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  metadata = {
   ssh-keys = "ubuntu:${file(var.key_name)}"
  }

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = file(var.pvt_key)
    host	= google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
  }

  provisioner "file" {
    source      = "./frontend"
    destination = "~/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/frontend/run_frontend.sh",
      "cd ~/frontend",
      "sudo ~/frontend/run_frontend.sh",
    ]
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}

resource "google_compute_firewall" "default" {
 name    = "apache2-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["80","443"]
 }
}

output "ip" {
 value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}
