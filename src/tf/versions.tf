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
  project = local.project
  region  = local.region
}

provider "google-beta" {
  project = local.project
  region  = local.region
}

terraform {
  backend "local" {}
  required_providers {
    google      = "~> 2.20"
    google-beta = "~> 2.20"
  }
  required_version = "~> 0.12"
}
