# Kyverno examples

This folder contains ready-to-use Kyverno policies and a `kustomization.yaml` to apply them all at once.

## Prerequisites

- Minikube
- kubectl
- Helm

## Install Kyverno

Option A: Helm

```bash
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
helm install kyverno kyverno/kyverno -n kyverno --create-namespace
```

Option B: Manifests

```bash
kubectl create namespace kyverno || true
kubectl apply -n kyverno -f https://raw.githubusercontent.com/kyverno/kyverno/main/config/install-latest.yaml
```

Wait until pods are Ready:

```bash
kubectl -n kyverno get pods
```

## Apply all policies in this folder

```bash
kubectl apply -k .
```

To remove all policies:

```bash
kubectl delete -k .
```

## Contents

- policies/require-namespace-label.yaml — require a standard label on every Namespace
- policies/disallow-latest-tag.yaml — block images using the `:latest` tag
- policies/block-privileged.yaml — block pods that request privileged escalation
- policies/require-requests-limits.yaml — require CPU/Memory requests and limits on Pods
- policies/add-default-seccontext.yaml — mutate Pods with default securityContext when missing

## Quick tests

# Kyverno policy test manifests

This folder contains simple manifests to test each policy under `../policies/`.

Prereqs: Kyverno installed and the policies applied (from `kyberno/`):

```bash
kubectl apply -k ..
```

Test one file at a time to see allow/deny behavior.

## Disallow :latest tag

- Expect DENY:

```bash
kubectl apply -f tests/images/pod-latest.yaml
```

- Expect ALLOW:

```bash
kubectl apply -f tests/images/pod-pinned.yaml
```


## Namespace label policy

- Expect DENY:

```bash
kubectl apply -f tests/namespaces/namespace-no-label.yaml
```

- Expect ALLOW:

```bash
kubectl apply -f tests/namespaces/namespace-with-label.yaml
```


## Block privileged / escalation

- Expect DENY:

```bash
kubectl apply -f tests/security/pod-privileged.yaml
```

- Expect ALLOW:

```bash
kubectl apply -f tests/security/pod-nonpriv.yaml
```

## Require requests/limits

- Expect DENY:

```bash
kubectl apply -f tests/resources/pod-no-resources.yaml
```

- Expect ALLOW:

```bash
kubectl apply -f tests/resources/pod-with-resources.yaml
```

## Default securityContext mutation

- Expect MUTATION (allowed + defaults injected):

```bash
kubectl apply -f mutation/pod-mutate-defaults.yaml
kubectl get pod mutate-defaults -o yaml | grep -A5 securityContext
```

Cleanup

```bash
kubectl delete -f tests/namespaces/namespace-with-label.yaml --ignore-not-found
kubectl delete -f tests/images/pod-pinned.yaml --ignore-not-found
kubectl delete -f tests/security/pod-nonpriv.yaml --ignore-not-found
kubectl delete -f tests/resources/pod-with-resources.yaml --ignore-not-found
kubectl delete -f tests/mutation/pod-mutate-defaults.yaml --ignore-not-found
kubectl delete ns test-with-label --ignore-not-found
kubectl delete pod bad-latest good-pin bad-priv no-resources defaults-added mutate-defaults --ignore-not-found
```