# Terraform Lab

This is the first iteration of a terraform lab on GKE

## Motivation

Increased operational confidence with versioning IaaS provisioned infrastructure

## Prerequisites

1. Google Cloud Platform
    - [Google Cloud SDK][gcloud-sdk]
    - A billable (or trial) project
1. [`kubectl`][kubectl-download]
    - `brew install kubernetes-cli` or `gcloud components install kubectl`
1. [`terraform`][tf-download]
    - `brew install terraform` or use the method from the `hack` folder in the `00-bootstrap` branch

## Gotcha

This lab uses a git based workflow so you'll be expected to work in branches!

Here's what that might look like:

```sh
# fetch updated branches
$ git fetch
remote: Counting objects: 3, done.
remote: Total 3 (delta 2), reused 2 (delta 2), pack-reused 0
Unpacking objects: 100% (3/3), done.
From https://github.com/j0npulsifer/terraform-lab
   c6c44e6..c439c4f  master     -> origin/master
   6f4a43e..624fa8e  01-nextweek -> origin/01-nextweek

# checkout a different branch
$ git checkout 00-bootstrap
$ ls -l
drwxr-sr-x 4 you you  4096 Mar 18 23:09 .
drwxr-sr-x 3 you you  4096 Mar 18 22:50 ..
drwxr-sr-x 2 you you  4096 Mar 18 23:09 hack
```

## Installation & Configuration
1. Install the prerequisites and ensure they're present in your `PATH`
1. Authenticate to `gcloud` by performing `gcloud auth login`
1. Check out the `bootstrap` branch and read `README.md`

[gcloud-sdk]: https://cloud.google.com/sdk/
[kubectl-download]: https://kubernetes.io/docs/tasks/tools/install-kubectl/
[tf-download]: https://www.terraform.io/downloads.html
[tf-provider]: https://github.com/terraform-providers/terraform-provider-google
[tf-google-docs]: https://www.terraform.io/docs/providers/google/index.html
