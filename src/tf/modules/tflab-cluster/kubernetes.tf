# fetch the latest GKE versions for the zone
data "google_container_engine_versions" "lab" {
  location = var.zone
}

# create and configure a GKE cluster
resource "google_container_cluster" "lab" {
  provider = google-beta
  # GKE requires a network, subnet, and service account
  depends_on = [
    google_service_account.nodes,
    google_compute_network.gke,
    google_compute_subnetwork.nodes,
  ]

  # GKE Cluster name
  name = "tflab-${var.name}"

  # Human readable description of this cluster
  description = "tflab - ${var.name}'s cluster"

  # The zone where the master will be hosted
  location = var.zone

  # Use the latest GKE release for the master and worker nodes
  min_master_version = data.google_container_engine_versions.lab.latest_node_version
  node_version       = data.google_container_engine_versions.lab.latest_node_version

  # use the networks we create
  network    = google_compute_network.gke.self_link
  subnetwork = google_compute_subnetwork.nodes.name

  # Prefer use IAM and RBAC for auth
  master_auth {
    # disable basic authentication
    username = ""
    password = ""

    # disable client certificate generation
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # disable the ABAC authorizer
  enable_legacy_abac = "false"

  # enable NetworkPolicy
  network_policy {
    enabled  = var.enable_network_policy
    provider = var.enable_network_policy ? "CALICO" : "PROVIDER_UNSPECIFIED"
  }

  # enable PodSecurityPolicy
  pod_security_policy_config {
    enabled = var.enable_pod_security_policy
  }

  # enable shielded Vms
  enable_shielded_nodes = var.enable_shielded_nodes

  # disable the l7 gclb controller
  addons_config {
    http_load_balancing {
      disabled = true
    }

    network_policy_config {
      disabled = var.enable_network_policy ? false : true
    }
  }

  # GKE requires a node pool to be created on creation
  # how many do you want?
  initial_node_count = var.initial_node_count

  # configure the GCE instances
  node_config {
    machine_type    = var.machine_type
    service_account = google_service_account.nodes.email

    # enable the Metadata Concealment workload proxy
    workload_metadata_config {
      node_metadata = "SECURE"
    }

    shielded_instance_config {
      enable_secure_boot          = var.enable_shielded_nodes
      enable_integrity_monitoring = var.enable_shielded_nodes
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
