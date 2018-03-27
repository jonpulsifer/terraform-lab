# This is the GCP service account identity that your GCE instances
# will have and use for their API calls and platform operations
# https://cloud.google.com/compute/docs/access/service-accounts
resource "google_service_account" "nodes" {
  account_id   = "gke-nodes-${var.gcp_config["name"]}"
  display_name = "${var.gcp_config["name"]}'s GKE cluster node SA"
}

# In this lab your GKE nodes will need to access GCR for their storage
# so we give them roles/storage.objectViewer on the entire project because
# reasons
resource "google_project_iam_member" "gcr-for-gke-nodes" {
  project = "${var.gcp_config["project"]}"
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.nodes.email}"
}
