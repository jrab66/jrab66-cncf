# Demo with containers and kind 

demo based in mongo mean stack demo 

ref: https://www.mongodb.com/languages/mean-stack-tutorial

prequisites

* docker 

ref: https://docs.docker.com/engine/install/


* nvm

ref: https://github.com/nvm-sh/nvm#installing-and-updating
~~~
nvm install 16.13.0
Downloading and installing node v16.13.0...
Downloading https://nodejs.org/dist/v16.13.0/node-v16.13.0-darwin-arm64.tar.xz...
############################################################################################################################################################################################################### 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Now using node v16.13.0 (npm v8.1.0)
Creating default alias: default -> 16.13.0 (-> v16.13.0)
~~~


* kubectl 

~~~
brew install kubectl
~~~

ref: https://kubernetes.io/docs/tasks/tools/

* kind 

~~~
brew install kind

~~~
ref: https://kind.sigs.k8s.io/docs/user/quick-start/


#### Download example repo 

git clone 

ref: https://github.com/mongodb-developer/mean-stack-example

### create dummy mongodb db

populate .env over '/server'
~~~
ATLAS_URI=mongodb+srv://<username>:<password>@sandbox.jadwj.mongodb.net/meanStackExample?retryWrites=true&w=majority
~~~


#### create local docker images


server image 
~~~
cd server 
docker build -t server .
~~~


client image
~~~
cd client
docker build -t web  .
~~~


#### create kind cluster 

~~~
./kind-local-registry.sh
~~~

ref: https://kind.sigs.k8s.io/docs/user/local-registry/





#### push images to local registry to use with kind 

~~~

docker tag web localhost:5001/web:1.0
docker push localhost:5001/web:1.0


docker tag web localhost:5001/server:1.0
docker push localhost:5001/server:1.0
~~~

#### apply manifest to cluster

~~~
kubectl apply -f server.yaml 
kubectl apply -f web.yaml 
~~~


expose ports 

~~~
kubectl port-forward deployment/web 8080:8080

kubectl port-forward deployment/server 5200:5200

~~~
