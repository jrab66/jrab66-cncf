# Kyverno policy test manifests

This folder contains simple manifests to test each policy under `../policies/`.

Prereqs: Kyverno installed and the policies applied (from `kyberno/`):

```bash
kubectl apply -k ..
```

Test one file at a time to see allow/deny behavior.

## Namespace label policy

- Expect DENY:

```bash
kubectl apply -f namespaces/namespace-no-label.yaml
```

- Expect ALLOW:

```bash
kubectl apply -f namespaces/namespace-with-label.yaml
```

## Disallow :latest tag

- Expect DENY:

```bash
kubectl apply -f images/pod-latest.yaml
```

- Expect ALLOW:

```bash
kubectl apply -f images/pod-pinned.yaml
```

## Block privileged / escalation

- Expect DENY:

```bash
kubectl apply -f security/pod-privileged.yaml
```

- Expect ALLOW:

```bash
kubectl apply -f security/pod-nonpriv.yaml
```

## Require requests/limits

- Expect DENY:

```bash
kubectl apply -f resources/pod-no-resources.yaml
```

- Expect ALLOW:

```bash
kubectl apply -f resources/pod-with-resources.yaml
```

## Default securityContext mutation

- Expect MUTATION (allowed + defaults injected):

```bash
kubectl apply -f mutation/pod-mutate-defaults.yaml
kubectl get pod mutate-defaults -o yaml | grep -A5 securityContext
```

Cleanup

```bash
kubectl delete -f namespaces/namespace-with-label.yaml --ignore-not-found
kubectl delete -f images/pod-pinned.yaml --ignore-not-found
kubectl delete -f security/pod-nonpriv.yaml --ignore-not-found
kubectl delete -f resources/pod-with-resources.yaml --ignore-not-found
kubectl delete -f mutation/pod-mutate-defaults.yaml --ignore-not-found
kubectl delete ns test-with-label --ignore-not-found
kubectl delete pod bad-latest good-pin bad-priv no-resources defaults-added mutate-defaults --ignore-not-found
```
