# Terraform Lab

This is the third iteration of a terraform lab on GKE

## Motivation

Increased operational confidence with versioning IaaS provisioned infrastructure

## Prerequisites

1. Google Cloud Platform
    - [Google Cloud SDK][gcloud-sdk]
    - A billable (or trial) project
1. [`kubectl`][kubectl-download]
    - `gcloud components install kubectl`
1. [`terraform`][tf-download]
    - `brew install terraform`

## Slides

1. The slides are available using golang's `[present][present-tool]` tool and the content is found in `lab.slides`

[gcloud-sdk]: https://cloud.google.com/sdk/
[kubectl-download]: https://kubernetes.io/docs/tasks/tools/install-kubectl/
[tf-download]: https://www.terraform.io/downloads.html
[tf-provider]: https://github.com/terraform-providers/terraform-provider-google
[tf-google-docs]: https://www.terraform.io/docs/providers/google/index.html
[present-tool]: https://github.com/golang/talks
