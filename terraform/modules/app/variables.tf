variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to publick key used for ssh access"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable database_url {
  description = "Database_url for reddit app"
  default     = "127.0.0.1:27017"
}

variable private_key_path {
  description = "Path to the private key used for ssh provisioners"
}