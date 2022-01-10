terraform {
  # Terraform version
  required_version = "0.11.11"
}

provider "google" {
  # Provider version
  version = "1.19.1"
  # Project ID
  project = "${var.project}"
  region = "${var.region}"
}