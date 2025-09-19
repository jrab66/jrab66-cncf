# Kubernetes Demos and Tools

Welcome to my personal collection of Kubernetes demos and tools! This repository showcases various Kubernetes setups and configurations I've worked with, focusing on both local development and cloud deployments. Each demo is self-contained with its own documentation, making it easy to explore different aspects of Kubernetes and Cloud Computing.

## 🚀 Available Demos

### 1. [Kyberno Policy Demo](kyberno/README.md)
Comprehensive Kyverno policy examples demonstrating Kubernetes security and governance:
- Namespace label requirements and validation
- Container image security policies (blocking :latest tags)
- Pod security controls (privileged containers, resource limits)
- Security context mutations and defaults
- Ready-to-use policy collection with testing examples

### 2. [Minikube Local Development](minikube/README.md)
A comprehensive local Kubernetes development environment featuring:
- Local development with automatic code reloading
- HTTPS with locally-trusted certificates using mkcert
- Ingress configuration for external access
- Automated certificate management with cert-manager
- Helm chart deployment examples

### 3. [Glasskube Operator Demo](glasskube-demo/README.md)
Demonstrates the capabilities of the Glasskube operator for managing Kubernetes applications, including:
- Application lifecycle management
- Dependency resolution
- Configuration management
- Automated updates

### 4. [Kind + Docker Demo](kind-docker-demo/README.md)
A streamlined local Kubernetes development setup featuring:
- Local container registry integration
- Fast container image building and testing
- Isolated development environments
- Simplified Kubernetes testing workflow

### 5. [GKE Deployment](gke/README.md)
Terraform-based deployment for Google Kubernetes Engine (GKE) demonstrating:
- Infrastructure as Code (IaC) with Terraform
- Production-ready GKE cluster configuration
- Network and security best practices
- Integration with Google Cloud services

## 🛠 Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Docker](https://docs.docker.com/get-docker/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) (for GKE demo)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/) (for local development)
- [mkcert](https://github.com/FiloSottile/mkcert) (for local HTTPS)

## 📚 Getting Started

### Option 1: Clone the repository (read-only)
```sh
git clone https://github.com/yourusername/your-repo.git
cd your-repo
```

### Option 2: Fork and clone (recommended for contributions)
1. Click the "Fork" button at the top-right of this repository
2. Clone your forked repository:
   ```sh
   git clone https://github.com/YOUR-USERNAME/your-repo.git
   cd your-repo
   ```
3. Add the upstream repository:
   ```sh
   git remote add upstream https://github.com/original-owner/your-repo.git
   ```

### Next Steps
1. Navigate to the demo of your choice
2. Follow the specific instructions in each demo's README

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
