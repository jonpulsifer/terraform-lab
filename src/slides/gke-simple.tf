resource "google_container_cluster" "primary" {
  name               = "defaults-are-secure-i-promise"
  zone               = "northamerica-northeast1-c"
  initial_node_count = 3
}
