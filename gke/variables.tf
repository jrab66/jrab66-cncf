variable "project" {
  type    = string
  default = "playground-s-11-125f855d"
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