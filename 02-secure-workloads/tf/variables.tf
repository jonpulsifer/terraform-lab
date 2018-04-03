# https://www.terraform.io/docs/configuration/variables.html

# Google Cloud Platform variables
variable "gcp_config" {
  type = "map"

  default = {
    # This is the default project that your resources will deploy to
    # TODO: fill out the GCP project you are working in
    project = ""

    # This is the unique identifier for all the resources
    # that terraform will create on your behalf in this lab
    # regex [a-z]{1,8}
    # TODO: fill in your name (one word, matching the regex)
    name = ""

    # This is the default region and zone for your resources
    # https://cloud.google.com/compute/docs/regions-zones
    #                us-east4-c  region: us-east4                zone: us-east4-c
    # northamerica-northeast1-a  region: northamerica-northeast1 zone: northamerica-northeast1-a
    #                us-east1-a  region: us-east1-a              zone: us-east1-c
    # e.g. us-east1
    # TODO: fill in the region
    region = ""

    # e.g. us-east1-c
    # TODO: fill in the zone
    zone = ""
  }
}

# Google Kubernetes Engine (formerly Google Container Engine) variables
# This exposes some of the configuration for the GCE instances that are
# powering your GKE cluster
variable "gke_config" {
  type = "map"

  default = {
    # choose a /24 CIDR for your GKE nodes
    # try not to overlap with your peers
    # use an internal network
    # e.g. 192.168.42.0/24
    #      172.16.240.0/24
    #      10.13.37.0/24
    # TODO: fill in the CIDR
    node_cidr = ""

    # how many nodes do you need in your default node pool?
    initial_node_count = 2

    # how big do your machines need to be?
    # https://cloud.google.com/compute/docs/machine-types
    machine_type = "n1-standard-2"

    # how much hard drive space do you need?
    disk_size_gb = "64"
  }
}
