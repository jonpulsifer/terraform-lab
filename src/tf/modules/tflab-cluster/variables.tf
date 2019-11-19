variable "project" {
  type        = string
  description = "This is the default project that your resources will deploy to"
  default     = ""
}

variable "name" {
  type        = string
  description = "This is the unique identifier for all the resources that terraform will create on your behalf in this lab. Regex /[a-z]{1,8}/"
  default        = ""
}


variable "region" {
  type        = string
  description = "This is the default compute region for your resources. https://cloud.google.com/compute/docs/regions-zones"
  default     = ""
}

variable "zone" {
  type        = string
  description = "This is the default compute zone for your resources. https://cloud.google.com/compute/docs/regions-zones"
  default     = ""
}

variable "cidr" {
  type        = string
  description = "This is the RFC1918 private network CIDR for the virtual machines in this lab. Choose a /24 CIDR and try not to overlap with your peers"
  default     = ""
}

variable "initial_node_count" {
  type        = number
  description = "The initial node count for the GKE cluster"
  default     = 2
}

variable "machine_type" {
  type        = string
  description = "The machine type for the GKE cluster virtual machines. https://cloud.google.com/compute/docs/machine-types"
  default     = "n1-standard-2"
}

variable "enable_shielded_nodes" {
  type        = bool
  description = "Enable Shielded GKE Nodes https://cloud.google.com/kubernetes-engine/docs/how-to/shielded-gke-nodes"
  default     = true
}

variable "enable_network_policy" {
  type        = bool
  description = "Enable Kubernetes Network Policy https://kubernetes.io/docs/concepts/services-networking/network-policies"
  default     = true
}

variable "enable_pod_security_policy" {
  type        = bool
  description = "Enable Pod Security Policies https://cloud.google.com/kubernetes-engine/docs/how-to/pod-security-policies"
  default     = true
}
