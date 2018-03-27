# This is the GCP service account identity that your GCE instances
# will have and use for their API calls and platform operations
# https://cloud.google.com/compute/docs/access/service-accounts
resource "google_service_account" "nodes" {
  account_id   = "gke-nodes-${var.gcp_config["name"]}"
  display_name = "${var.gcp_config["name"]}'s GKE cluster node SA"
}
