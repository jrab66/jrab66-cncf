# Kyverno examples

This folder contains ready-to-use Kyverno policies and a `kustomization.yaml` to apply them all at once.

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

Open a new terminal and try the following after applying the policies.

1) Namespace label requirement

```bash
kubectl create ns test-no-label || true
# Expect: denied by Kyverno (missing required label)

kubectl create ns test-with-label --dry-run=client -o yaml \
  | kubectl label --local -f - env=dev --dry-run=client -o yaml \
  | kubectl apply -f -
# Expect: allowed, has env label
```

2) Disallow :latest images

```bash
kubectl -n default run bad-latest --image=nginx:latest --restart=Never || true
# Expect: denied by Kyverno

kubectl -n default run good-pin --image=nginx:1.27.2 --restart=Never
# Expect: allowed
```

3) Block privileged

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: bad-priv
spec:
  containers:
  - name: c
    image: busybox:1.36
    command: ["sh", "-c", "sleep 3600"]
    securityContext:
      privileged: true
EOF
# Expect: denied by Kyverno
```

4) Require requests/limits

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: no-resources
spec:
  containers:
  - name: c
    image: busybox:1.36
    command: ["sh", "-c", "sleep 3600"]
EOF
# Expect: denied by Kyverno
```

5) Default securityContext mutation

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: defaults-added
spec:
  containers:
  - name: c
    image: busybox:1.36
    command: ["sh", "-c", "id && sleep 5"]
EOF
kubectl get pod defaults-added -o yaml | grep -A3 securityContext
# Expect: runAsNonRoot, allowPrivilegeEscalation=false, seccompProfile=RuntimeDefault added
```

Notes
- Some policies are ClusterPolicies (cluster-scoped) and affect all namespaces.
- You can scope ClusterPolicy rules with match/exclude as needed.
