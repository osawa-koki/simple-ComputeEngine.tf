
variable "project_id" {
  type        = string
  description = "Id of the project."
}

variable "project_name" {
  type        = string
  default     = "simple-gcp-cloud-engine"
  description = "Name of the project."
}

variable "ssh_public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to the public key."
}

variable "allowed_ip_addresses" {
  type        = list(string)
  description = "IP addresses allowed to access the instance."
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

resource "google_compute_network" "example" {
  name = "${var.project_name}-network"
}

resource "google_compute_subnetwork" "example" {
  name          = "${var.project_name}-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.example.self_link
}

resource "google_compute_firewall" "example_ssh" {
  name    = "${var.project_name}-firewall-ssh"
  network = google_compute_network.example.name
  source_ranges = var.allowed_ip_addresses
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "example_http" {
  name    = "${var.project_name}-firewall-http"
  network = google_compute_network.example.name

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_instance" "example" {
  name         = "${var.project_name}-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt update"

  metadata = {
    ssh-keys = "my-user:${file(var.ssh_public_key_path)}"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.example.self_link

    access_config {
    }
  }
}

// IPアドレスを出力
output "ip_address" {
  value = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}
