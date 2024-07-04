

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"

  # no need for secondary ranges for gke
  # secondary_ip_range {
  #   range_name    = "services-range"
  #   ip_cidr_range = "192.168.1.0/24"
  # }

  # secondary_ip_range {
  #   range_name    = "pod-ranges"
  #   ip_cidr_range = "192.168.64.0/22"
  # }
}


# apply enabled!