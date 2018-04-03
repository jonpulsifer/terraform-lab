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
1. `gcloud container clusters get-credentials <cluster-name> --zone=<yourmasterzone>`
1. `kubectl config set-context $(kubectl config current-context) --namespace=tflab`

```sh
$ kubectl get cs
NAME                 STATUS    MESSAGE              ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-1               Healthy   {"health": "true"}
etcd-0               Healthy   {"health": "true"}
```

## Do the k8s

1. Ensure you fill out your email in `k8s/cluster-admin.yaml`
1. `kubectl apply -f k8s/cluster-admin.yaml`
1. `kubectl apply -f k8s/psp`
1. `kubectl apply -f k8s/namespaces/tflab`

At this point you should have two pods 
## Look at yer thing!

1. `kubectl get pods`
1. `kubectl port-forward webapp-12345 8080:8080`
1. Open a browser and navigate to [http://localhost:8080](http://localhost:8080)
1. Check the logs of your thing `kubectl logs deploy/webapp`
1. Observe the PSP the **webapp** workload is using `kubectl get po webapp-12345 -o yaml | grep psp`
1. Observe the PSP the **alpine** workload is using `kubectl get po alpine-12345 -o yaml | grep psp`

## Try to deploy a new workload

1. Create a default alpine deployment
    - `kubectl run myworkload --image=alpine -- tail -f /dev/null`
1. Did it start?
1. `kubectl get pods`
1. `kubectl describe po myworkload-12345`

## Allow some dangerous containers

1. Add `tflab-wide` to `k8s/psp/default-bindings.yaml`
1. Reconcile your RBAC `kubectl auth reconcile -f k8s/psp/default-bindings.yaml`
1. Create a new alpine deployment
1. `kubectl run mybadworkload --image=alpine -- tail -f /dev/null`
1. Observe your workload and the PSP it's running with

## Destroy your cluster :fire:

1. `terraform destroy`
