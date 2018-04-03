# fetch the latest GKE versions for the zone
data "google_container_engine_versions" "lab" {
  zone = "${var.gcp_config["zone"]}"
}

# create and configure a GKE cluster
resource "google_container_cluster" "lab" {
  # GKE requires a network, subnet, and service account
  depends_on = [
    "google_service_account.nodes",
    "google_compute_network.gke",
    "google_compute_subnetwork.nodes",
  ]

  # GKE Cluster name
  name = "tflab-${var.gcp_config["name"]}"

  # Human readable description of this cluster
  description = "tflab - ${var.gcp_config["name"]}'s cluster"

  # The zone where the master will be hosted
  zone = "${var.gcp_config["zone"]}"

  # Use the latest GKE release for the master and worker nodes
  min_master_version = "${data.google_container_engine_versions.lab.latest_node_version}"
  node_version       = "${data.google_container_engine_versions.lab.latest_node_version}"

  # inherit the network from terraform
  network    = "${google_compute_network.gke.self_link}"
  subnetwork = "${google_compute_subnetwork.nodes.name}"

  # disable the ABAC authorizer
  enable_legacy_abac = "false"

  # disable basic authentication
  master_auth {
    username = ""
    password = ""
  }

  # enable NetworkPolicy
  network_policy_config {
    enabled  = "true"
    provider = "CALICO"
  }

  # enable PodSecurityPolicy
  pod_security_policy_config {
    enabled = "true"
  }

  # disable the Kubernetes dashboard
  addons_config {
    http_load_balancing {
      disabled = true
    }
  }

  # GKE requires a node pool to be created on creation
  # how many do you want?
  initial_node_count = "${var.gke_config["initial_node_count"]}"

  # configure the GCE instances
  node_config {
    disk_size_gb    = "${var.gke_config["disk_size_gb"]}"
    machine_type    = "${var.gke_config["machine_type"]}"
    service_account = "${google_service_account.nodes.email}"

    # enable the Metadata Concealment workload proxy
    workload_metadata_config {
      node_metadata = "SECURE"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
