provider "google" {
 credentials = file("key.json")
 project     = "secops-xxxx"
 region      = "us-central1"
}

resource "random_id" "instance_id" {
 byte_length = 8
}

resource "google_compute_instance" "default" {
 can_ip_forward = false
 name           = "terraform-${random_id.instance_id.hex}"
 machine_type   = "f1-micro"
 zone           = "us-central1-a"


boot_disk {
    device_name = "disk1"  //disk name


  initialize_params {
    image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
    size  = "23"   //disk size
    type  = "pd-standard"  //pd-standard, pd-balanced or pd-ssd
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
