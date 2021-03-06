resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata = {
    "ssh-keys" = "appuser:${file(var.public_key_path)}"
  }

    # connection {
    #   type        = "ssh"
    #   user        = "appuser"
    #   agent       = false
    #   private_key = "${file(var.private_key_path)}"
    # }

    # provisioner "file" {
    #   source      = "${path.module}/files/set_env.sh"
    #   destination = "/tmp/set_env.sh"
    # }

    # provisioner "remote-exec" {
    #   inline = [
    #   "/bin/chmod +x /tmp/set_env.sh",
    #   "/tmp/set_env.sh ${var.database_url}"
    #   ]
    # }

    # provisioner "file" {
    #   source      = "${path.module}/files/puma.service"
    #   destination = "/tmp/puma.service"
    # }

    # provisioner "remote-exec" {
    #   script = "${path.module}/files/deploy.sh"
    # }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_nginx" {
  name    = "allow-nginx-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
