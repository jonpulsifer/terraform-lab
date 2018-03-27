# 00-bootstrap

## Prerequisites

:cloud: :rocket: Have fun!

### Updating Terraform
1. Determine terraform version with `terraform version`
1. Update terraform if necessary
    - `. hack/utils.sh && download-terraform 0.11.5 && sudo mv -v terraform /usr/local/bin/`

### Permissions

Ensure you have the `roles/owner` permission on the GCP project you are running this on

## Instructions
1. `cd tf`
1. Look through each of the files carefully, reading the comments and understanding what's happening
    1. `backend.tf`
    1. `provider.tf`
    1. `therestofthem.tf`
1. Edit `variables.tf` and `backend.tf` and fill in the blanks
1. `terraform init`
1. `terraform plan`
1. `terraform apply`
1. `gcloud container clusters get-credentials <cluster-name> --zone=<yourmasterzone>`

```sh
$ kubectl get cs
NAME                 STATUS    MESSAGE              ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-1               Healthy   {"health": "true"}
etcd-0               Healthy   {"health": "true"}
```

## FINALLY

:fire: `terraform destroy`
