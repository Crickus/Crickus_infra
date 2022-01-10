terraform {
  # Terraform version
  required_version = "0.11.11"
}

provider "google" {
  # Provider version
  version = "2.0.0"

  # Project ID
  project = "${var.project}"

  region = "${var.region}"
}

resource "google_compute_instance" "app" {
  count        = "${var.number_of_instances}"
  name         = "reddit-app-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata = {
    "ssh-keys" = <<EOT
        appuser:${file(var.public_key_path)}
        appuser1:${file(var.public_key_path)}
        appuser2:${file(var.public_key_path)}
    EOT
  }

#   connection {
#     type        = "ssh"
#     user        = "appuser"
#     agent       = false
#     private_key = "${file(var.private_key_path)}"
#   }

#   provisioner "file" {
#     source      = "files/puma.service"
#     destination = "/tmp/puma.service"
#   }

#   provisioner "remote-exec" {
#     script = "files/deploy.sh"
#   }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]   
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  description = "Allow SSH from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}