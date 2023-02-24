
variable "project_name" {
  type        = string
  default     = "simple-gce-instance"
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
  project = var.project_name
  region  = "asia-northeast1"
}

resource "google_compute_network" "example" {
  name = "example-network"
}

resource "google_compute_subnetwork" "example" {
  name          = "example-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.example.self_link
}

resource "google_compute_firewall" "example_ssh" {
  name    = "example-firewall"
  network = google_compute_network.example.name
  source_ranges = var.allowed_ip_addresses
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "example_http" {
  name    = "example-firewall"
  network = google_compute_network.example.name

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_instance" "example" {
  name         = var.project_name
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  metadata = {
    ssh-keys = "my-user:${file(var.ssh_public_key_path)}"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.example.self_link

    access_config {
      nat_ip = google_compute_address.example.address
    }
  }

  tags = [var.project_name]
}

resource "google_compute_address" "example" {
  name = "example-address"
}
