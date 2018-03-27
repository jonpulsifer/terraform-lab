resource "google_compute_network" "gke" {
  name                    = "tflab-${var.gcp_config["name"]}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "nodes" {
  depends_on               = ["google_compute_network.gke"]
  name                     = "tflab-${var.gcp_config["name"]}-nodes"
  region                   = "${var.gcp_config["region"]}"
  network                  = "${google_compute_network.gke.self_link}"
  ip_cidr_range            = "${var.gke_config["node_cidr"]}"
  private_ip_google_access = "true"
}
