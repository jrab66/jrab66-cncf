
# glasskube readme



prequisites

* minikube
* helm
* kubectl 

### minikube setup
more than minimal due to gitlab instance need more than default minikube size.

```
minikube start \
--cpus 4 \
--memory 8000 \
--disk-size=120g 
```


# glasskube prerequisites.

glasskube recommendation is to have those outside of the original glasskube deployment, and for more production setups probably cert-manager for example is already installed and maintain outside of the glasskube scope.


ref: [dependancies](https://glasskube.eu/docs/getting-started/dependencies/)


#### cloudnative-pg
operator for postgres instances!

```
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm upgrade --install cnpg \
  --namespace cnpg-system \
  --create-namespace \
  cnpg/cloudnative-pg
```

#### cert-manager
certificate management for k8s.


```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.14.2 \
  --set installCRDs=true
```



#### glasskube

add glasskube helm repo

```
helm repo add glasskube https://charts.glasskube.eu/
helm repo update
```

#### install 

```
helm upgrade --install glasskube glasskube/glasskube-operator -f values-reference.yaml

```




####  gitlab installation 
```
kubectl apply -f gitlab-glasskube.yaml
```






#### vault 
vault need selfsigned cert to works!.

apply selfsigned cert

```
kubectl apply -f cert-signed-vault.yaml

```

Create vault stack


```
kubectl apply -f vault.yaml
```





## delete demo

```
minikube delete
```

:)