resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh"
  network     = "default"
  description = "Allow SSH from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.source_ranges}"
}

# resource "google_compute_project_metadata_item" "default" {
#   key = "ssh-keys"
#   value = "appuser:${chomp(file(var.public_key_path))}"
# }