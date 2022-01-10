variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to publick key used for ssh access"
}

variable private_key_path {
  description = "Path to publick key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable "number_of_instances" {
  description = "Number of reddit-app instances (count)"
}