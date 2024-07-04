variable "project" {
  type    = string
  default = "playground-s-11-29dc0c8c"
}

variable "region" {
  type    = string
  default = "us-central1"
}

# GKE

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}