/* Terraform is used to create, manage, and update infrastructure
   resources such as physical machines, VMs, network switches,
   containers, and more. Almost any infrastructure type can be
   represented as a resource in Terraform.

   A provider is responsible for understanding API interactions and
   exposing resources. Providers generally are an IaaS (e.g. AWS, GCP,
   Microsoft Azure, OpenStack), PaaS (e.g. Heroku), or SaaS services
   (e.g. Terraform Enterprise, DNSimple, CloudFlare).
*/

# Google Cloud Platform provider configuration
provider "google" {
  project = var.gcp_config["project"]
  region  = var.gcp_config["region"]
  version = "~> 2.20"
}

provider "google-beta" {
  project = var.gcp_config["project"]
  region  = var.gcp_config["region"]
  version = "~> 2.20"
}
