#!/bin/bash

# Start Minikube if not running
minikube status >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Starting Minikube..."
  minikube start
fi

# Enable metrics-server
echo "Enabling metrics-server addon..."
minikube addons enable metrics-server

# Enable ingress
echo "Enabling ingress addon..."
minikube addons enable ingress

echo "Minikube is ready with metrics-server and ingress enabled."