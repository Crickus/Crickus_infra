terraform {
  # Terraform version
  required_version = "0.11.11"
}

provider "google" {
  # Provider version
  version = "2.0.0"

  # Project ID
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  private_key_path    = "${var.private_key_path}"
  database_url        = "${module.db.db_internal_ip}:27017"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
