# Minikube Local Development Setup

This project sets up a local Kubernetes development environment using Minikube, with support for:
- Local development with automatic code reloading
- HTTPS with locally-trusted certificates
- Ingress routing for external access
- Automated certificate management with cert-manager

## Prerequisites

Before you begin, ensure you have the following tools installed:


* [minikube](https://minikube.sigs.k8s.io/docs/start/) - Local Kubernetes development environment
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) - Kubernetes command-line tool
* [helm](https://helm.sh/docs/intro/install/) - Package manager for Kubernetes
* [mkcert](https://github.com/FiloSottile/mkcert) - Tool for making locally-trusted development certificates
* [k9s](https://k9scli.io/) - Terminal UI for Kubernetes cluster interaction

## 🛠️ Optional Tools

### k9s - Terminal UI for Kubernetes

k9s provides a terminal UI to interact with your Kubernetes clusters. It's a great alternative to `kubectl` for daily operations.

For installation and detailed usage, refer to the [official k9s documentation](https://k9scli.io/).

# minikube

create minikube cluster
```sh
./script.sh
```





## Application Deployment

### Default Installation

Deploy the application using the default configuration:

```sh
helm upgrade --install demo-helm helm-chart-demo 
```

**What this does:**
- Creates a new Helm release named `demo-helm`
- Uses the chart located in the `helm-chart-demo` directory
- Applies default values from the chart

**Note:** This basic installation doesn't include Ingress or TLS configuration. Use the Ingress installation method below for production-like setups.


#### accessing the application

```sh
kubectl port-forward svc/demo-helm 8080:80
```


# Advanced Configuration

## Local TLS Certificates with mkcert

To enable HTTPS in your local development environment, we use `mkcert` to create locally-trusted certificates.

### Generate Certificate

```sh
mkcert 192.168.49.2.nip.io
```

**Expected Output:**
```
Created a new certificate valid for the following names 📜
 - "192.168.49.2.nip.io"

The certificate is at "./192.168.49.2.nip.io.pem" and the key at "./192.168.49.2.nip.io-key.pem" ✅

It will expire on 8 August 2027 🗓
```

**What this does:**
- Creates a new SSL/TLS certificate valid for `192.168.49.2.nip.io`
- Generates both certificate (`.pem`) and private key (`-key.pem`) files
- The certificate is trusted by your local machine, allowing secure HTTPS connections

**Note:** The certificate is valid for 90 days by default. You'll need to regenerate it after expiration.

## Automated Certificate Management with cert-manager

cert-manager automates the management and issuance of TLS certificates from various issuing sources. This setup configures cert-manager to work with your local Minikube cluster.

### Installation

Run the setup script to install cert-manager and configure it for local development:

```sh
./certs.sh
```

**What this script does:**
1. Installs cert-manager in the `cert-manager` namespace
2. Configures a ClusterIssuer for automatic certificate generation
3. Sets up the necessary RBAC permissions
4. Creates a test certificate to verify the installation

**Verification:**
After running the script, you can verify the installation with:
```sh
kubectl get pods -n cert-manager
```
You should see the cert-manager pods in a `Running` state.

## Ingress Installation

This command deploys your application with Ingress configuration, enabling external access to your services.

```sh
helm upgrade --install demo-helm helm-chart-demo -f ingress.yaml 
```

### What this does:
- `upgrade --install`: Upgrades if release exists, or installs if it doesn't
- `demo-helm`: Name of the Helm release
- `helm-chart-demo`: Directory containing your Helm chart
- `-f ingress.yaml`: Applies the Ingress configuration from ingress.yaml



# Podinfo Demo Application

This section deploys the Podinfo demo application, a simple microservice that showcases various Kubernetes features.

## Deployment Steps

1. **Create a namespace** for the application:
   ```sh
   kubectl create namespace test
   ```
   - Creates a dedicated namespace called 'test' to isolate the deployment

2. **Add the Podinfo Helm repository**:
   ```sh
   helm repo add podinfo https://stefanprodan.github.io/podinfo
   ```
   - Adds the official Podinfo Helm chart repository
   - This makes the Podinfo chart available for installation

3. **Deploy Podinfo using Helm**:
   ```sh
   helm upgrade --install --wait frontend \
   --namespace test \
   --set replicaCount=2 \
   --set backend=http://backend-podinfo:9898/echo \
   podinfo/podinfo -f pod-info-ingress.yaml
   ```
   - `upgrade --install`: Upgrades if exists, otherwise installs
   - `--wait`: Waits for all resources to be ready
   - `frontend`: Name of the Helm release
   - `--namespace test`: Deploys to the 'test' namespace
   - `--set replicaCount=2`: Creates 2 pod replicas for high availability
   - `--set backend=...`: Configures the backend service endpoint
   - `podinfo/podinfo`: Specifies the chart to install
   - `-f pod-info-ingress.yaml`: Applies custom Ingress configuration


### Prerequisites:
- Cert-manager must be installed (see cert-manager setup above)
- NGINX Ingress Controller should be running in your cluster
- Valid TLS certificates should be available (handled by cert-manager)

After running this command, your application will be accessible at:
- HTTPS: https://demo.192.168.49.2.nip.io



> **Note:** `192.168.49.2` is the default IP address of the Minikube VM when using the Docker driver. This is a special "magic" IP that routes to the Minikube host from inside containers. If you're using a different driver or have customized your setup, you may need to adjust this IP address accordingly. You can find your Minikube IP by running `minikube ip`.
