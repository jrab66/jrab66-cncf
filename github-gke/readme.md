### steps


enable service account 

```
export GOOGLE_APPLICATION_CREDENTIALS=credentials.json
gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
gcloud config set project $PROJECT_ID

```



actvate `apis`
```
gcloud services enable \
	containerregistry.googleapis.com \
	container.googleapis.com

```


```
     gcloud services enable \                        
        containerregistry.googleapis.com \
        container.googleapis.com
Operation "operations/acf.p2-994698214235-7d7c9590-5f3b-4df2-97bf-dd7a0bc3fece" finished successfully.

```

# create gke cluster

```
  export PROJECT_ID="playground-s-11-6e2c7a0e"
  export GKE_CLUSTER="playground-test"
  export GKE_ZONE="us-central1"
  gcloud container clusters create $GKE_CLUSTER \
    --project=$PROJECT_ID \
    --zone=$GKE_ZONE \
    --num-nodes 1
    --machine-type n1-standard-2 \
    --disk-size=100GB
```


get credentials

```
gcloud container clusters get-credentials playground-test --project $PROJECT_ID
```

# create base64 credentials secret for github actions 

```
export GKE_SA_KEY=$(cat credentials.json | base64)
```

