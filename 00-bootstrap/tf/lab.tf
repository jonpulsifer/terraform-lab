locals {
  # TODO: fill in your or a unique name for the cluster matching the regex [a-z]{1,8}
  name = ""

  # TODO: fill out the GCP project you are working in
  project = ""

  # https://cloud.google.com/compute/docs/regions-zones
  #                us-east4-c  region: us-east4                zone: us-east4-c
  # northamerica-northeast1-a  region: northamerica-northeast1 zone: northamerica-northeast1-a
  #                us-east1-a  region: us-east1-a              zone: us-east1-c
  # TODO: fill in the region
  region = ""
  zone   = join("-", [local.region, "b"])

  # choose a /24 CIDR for your GKE nodes
  # try not to overlap with your peers
  # use an internal network
  # e.g. 192.168.42.0/24
  #      172.16.240.0/24
  #      10.13.37.0/24
  # TODO: fill in the CIDR
  cidr = ""
}

module "not-secure-enough" {
  source                     = "../../src/tf/modules/tflab-cluster"
  name                       = local.name
  region                     = local.region
  zone                       = local.zone
  cidr                       = local.cidr
  enable_network_policy      = false
  enable_pod_security_policy = false
}
