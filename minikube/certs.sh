#!/bin/bash

set -e

echo "creating namespace for cert-manager"
kubectl create namespace cert-manager || true
helm repo add jetstack https://charts.jetstack.io
helm repo update
echo "installing helm chart"
helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.14.4 \
  --set installCRDs=true

echo "cert-manager deployed."



kubectl create secret tls mkcert-ca-key-pair \
  --key "$(mkcert -CAROOT)/rootCA-key.pem" \
  --cert "$(mkcert -CAROOT)/rootCA.pem" -n cert-manager


kubectl apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: mkcert-issuer
  namespace: cert-manager
spec:
  ca:
    secretName: mkcert-ca-key-pair
EOF