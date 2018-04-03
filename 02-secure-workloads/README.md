# 02-secure-workloads

## Prerequisites

:cloud: :rocket: Have fun!

### Docker
1. Ensure you have Docker installed, running and available via `docker version`

### Updating/Install Terraform
1. Determine terraform version with `terraform version`
1. Update `terraform` if necessary. e.g.
    - `. ../hack/utils.sh && download-terraform 0.11.5 && sudo mv -v terraform /usr/local/bin/`

### Permissions :lock:

Ensure you have the `roles/owner` permission on the GCP project you are using for this lab

## Instructions

## Create your GKE cluster :package: :cloud:

1. Replace variables in `backend.tf` and `variables.tf`
1. `terraform init`
1. `terraform plan`
1. `terraform apply`

## Obtain credentials for your cluster :key:
1. In order to interact with your newly created GKE cluster, you must obtain credentials to communicate with the Kubernetes master. Run the following command to configure your `~/.kube/config` file such that you can interact with your cluster using `kubectl`

```gcloud container clusters get-credentials <cluster-name> --zone=<yourmasterzone>```

```sh
$ kubectl get cs
NAME                 STATUS    MESSAGE              ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-1               Healthy   {"health": "true"}
etcd-0               Healthy   {"health": "true"}
```

## Do the k8s
1. `kubectl apply -f k8s/cluster-admin.yaml`
1. `kubectl apply -f k8s/psp`
1. `kubectl apply -f k8s/namespaces/webapp`

## Look at yer thing!
1. `kubectl port-forward webapp-12345 8080:8080`
1. Open a browser and navigate to [http://localhost:8080](http://localhost:8080)
1. Check the logs of your thing `kubectl logs deploy/webapp`
1. Observe the PSP the workload is using `kubectl get po webapp-12345 -o yaml | grep psp`

## Destroy your cluster :fire:

1. `terraform destroy`
