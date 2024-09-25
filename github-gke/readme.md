### steps


# setup GCP

execute `setup-demo.sh` to activate credentials, activate apis and create GKE cluster.


```
./setup-demo.sh
```

# create base64 credentials secret for github actions 

```
export GKE_SA_KEY=$(cat credentials.json | base64)

```

copy credentials to github actions secret.

```
echo $GKE_SA_KEY | xclip -selection clipboard
```





### Load testing

```
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://demo-service; done"


```