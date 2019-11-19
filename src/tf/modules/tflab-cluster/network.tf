resource "google_compute_network" "gke" {
  name                    = "tflab-${var.name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "nodes" {
  depends_on               = [google_compute_network.gke]
  name                     = "tflab-${var.name}-nodes"
  region                   = var.region
  network                  = google_compute_network.gke.self_link
  ip_cidr_range            = var.cidr
  private_ip_google_access = "true"
}

# allow SSH access to your nodes
resource "google_compute_firewall" "gke-ssh" {
  depends_on = [
    google_service_account.nodes,
    google_compute_network.gke,
  ]

  name    = "tflab-${var.name}-ssh"
  network = google_compute_network.gke.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = [google_service_account.nodes.email]
}

# allow ICMP to your nodes
resource "google_compute_firewall" "icmp" {
  depends_on = [
    google_service_account.nodes,
    google_compute_network.gke,
  ]

  name    = "tflab-${var.name}-icmp"
  network = google_compute_network.gke.name

  allow {
    protocol = "icmp"
  }

  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = [google_service_account.nodes.email]
}
