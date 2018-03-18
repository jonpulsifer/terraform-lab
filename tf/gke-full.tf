data "google_container_engine_versions" "lab" {
  # aka USA north (Montreal)
  zone = "northamerica-northeast1-c"
}

resource "google_container_cluster" "lab" {
  # simple doesn't mean secure
  name        = "defaults-are-secure-amirite"
  description = "artisintally PRd TF GKE cluster"

  # keep master up to date w/ the latest avail in the zone
  min_master_version = "${data.google_container_engine_versions.lab.latest_node_version}"
  zone               = "northamerica-northeast1-c"

  # we need these because reasons
  depends_on = [
    "google_service_account.nodes",
    "google_compute_network.gke",
    "google_compute_subnetwork.nodes",
  ]

  # IP Aliasing
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # Turn off ABAC
  enable_legacy_abac = "false"

  # Enable NetworkPolicies
  network_policy {
    enabled  = "true"
    provider = "CALICO"
  }

  # addons config
  addons_config {}

  timeouts {
    create = "20m"
    delete = "15m"
  }
}
