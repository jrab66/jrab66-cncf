
# my first gke cluster

Creating your first GKE cluster using Terraform involves defining infrastructure as code for Kubernetes clusters on Google Cloud Platform:

Define Configuration: Write Terraform code specifying GKE cluster details, such as node pools, machine types, and Kubernetes version.

Deployment: Execute terraform init to initialize, terraform plan to preview changes, and terraform apply to create the cluster.

Cluster Provisioning: Terraform automates provisioning of GKE resources, including networking, nodes, and Kubernetes control plane.


# prerequisites

some google cloud account, we are going to use `credentials.json` to authenticate in this demo.

ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference

* terraform/opentofu
* gcp account 



## load credentials

```
export GOOGLE_APPLICATION_CREDENTIALS=credentials.json

```

## initialize terraform folder

```
terraform init
```

## plan resources  terraform 

```
terraform plan
```


## apply  resources  terraform 

```
terraform apply
```


## apply service via terraform

uncomment `kubernetes.tf` content to apply kubernetes manifest to cluster and apply again


```


## review cluster in GCP CONSOLE

check gke cluster from GCP console

```


# install service service

kubectl apply -k github.com/stefanprodan/podinfo//kustomize




# destroy resources

```
terraform destroy
```


# acloudguru

this apply is only needed at my account because my current setup.

```
terraform apply --target=google_project_service.gke
`
``
