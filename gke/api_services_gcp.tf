variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com"
  ]
}

resource "google_project_service" "gke" {
  for_each = toset(var.gcp_service_list)
  project = var.project
  service = each.key
}