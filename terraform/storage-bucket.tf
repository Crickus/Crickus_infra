provider "google" {
    version = "2.0.0"
    project = "${var.project}"
    region  = "${var.region}"
}

module "storage_bucket" {
    source = "SweetOps/storage-bucket/google"
    version = "0.1.1"

    name = ["my_storage-bucket-test", "my_second_storage-bucket-test"]
}

output storage-bucket_url {
    value = "${module.storage_bucket.url}"
}