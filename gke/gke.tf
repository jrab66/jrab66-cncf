# GKE cluster
# data "google_container_engine_versions" "gke_version" {
#   location       = var.region
#   version_prefix = "1.29."
# }


resource "google_container_cluster" "primary" {
  name     = "${var.project}-gke"
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = false
  initial_node_count       = 1

  deletion_protection = false

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  # ip_allocation_policy {
  #   # cluster_ipv4_cidr_block  = google_compute_subnetwork.subnet.secondary_ip_range.1.ip_cidr_range
  #   services_ipv4_cidr_block = google_compute_subnetwork.subnet.secondary_ip_range.0.ip_cidr_range
  # }

}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.primary.name
  location = var.region
  cluster  = google_container_cluster.primary.name

  version    = "1.29.4-gke.1043002" # for production use `data "google_container_engine_versions"`
  node_count = var.gke_num_nodes

  node_config {
    disk_size_gb = "60"
    disk_type    = "pd-standard"
    # oauth_scopes = [
    #   "https://www.googleapis.com/auth/logging.write",
    #   "https://www.googleapis.com/auth/monitoring",
    #   "https://www.googleapis.com/auth/cloud-platform",
    # ]

    labels = {
      env = var.project
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  depends_on = [ google_project_service.gke ]
}


