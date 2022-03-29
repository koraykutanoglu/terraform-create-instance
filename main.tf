// Configure the Google Cloud provider
provider "google" {
 credentials = file("key.json")
 project     = "secops-xxxx"
 region      = "us-central1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "terraform-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-central1-a"

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}
