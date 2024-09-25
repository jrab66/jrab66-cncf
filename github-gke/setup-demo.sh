#!/bin/bash

echo "setting demo account resources"

export PROJECT_ID="playground-s-11-9031b797"
export GKE_CLUSTER="playground-test"
export GKE_ZONE="us-central1"
export GOOGLE_APPLICATION_CREDENTIALS=credentials.json

echo "enable service account"

gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
gcloud config set project $PROJECT_ID

echo "enable GCP api's needed"

gcloud services enable \
	containerregistry.googleapis.com \
	container.googleapis.com


echo "create GKE cluster GCP"


gcloud container clusters create $GKE_CLUSTER \
  --project=$PROJECT_ID \
  --zone=$GKE_ZONE \
  --num-nodes 1
  --machine-type n1-standard-2 \
  --disk-size=100GB


echo "get gke kubeconfig/credentials"

gcloud container clusters get-credentials $GKE_CLUSTER --zone $GKE_ZONE --project $PROJECT_ID
