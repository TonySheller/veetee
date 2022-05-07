# Minikube Getting Started

Minikube is a preferred way to start developing with minikube.  It lets one setup a very simple K8s cluster and work with K8s concepts almost immediately.  This section will detail how to get that setup. It'll also strongly encourage (insist) that *kubectl* and *helm* are installed as well. 

# Get Minikube

One can search the internet for this but the best resource is problably the [MiniKube getting started page](https://minikube.sigs.k8s.io/docs/start/). I used Linux, actually Windows, Sub-system for Linux 2 (WSL2) so followed the Linux instructions.

```.shell

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

```

## Minikube start

Just like that `minikube start` and *poof* a K8s cluster. OK, it's only one node but one can do alot of work with it.


## kubectl install

A `kubectl` should really be installed. This is one of the the main ways a K8s adminstrator works with a cluster. Following the instructions from the K8s [Install and Setup Kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/):

```.shell

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl

```


## Helm install

The [Helm download site on GitHub](https://github.com/helm/helm/releases) is a terrific resource. Download the version needed for your OS. [Linux amd64](https://get.helm.sh/helm-v3.8.1-linux-amd64.tar.gz) might be a good choice.

```.shell

tar xvf helm-v3.8.1-linux-amd64.tar.gz
sudo install helm /usr/local/bin/helm

```

Note that `sudo install` works on Ubuntu.


## Loading your images so they will work in Minikube 
Minikube has its own internal docker registry so it is necessary to copy the image in if its not in docker hub.  Minikube will check first in its local repo and then in Docker Hub. If you have an image in the docker desktop repository then you can get it into the Minikube repo' by:  

```.shell
minikube image load ashelle5/veetee:0.1
```


## The better option, Just build the image so its in MiniKube's repository

Launch this at the shell you will be working from and then whenever a container is built it will be deployed to the MiniKube repository.

```.shell

eval $(minikube docker-env)

```
Now when `docker build --no-cache -t ashelle5/veetee` is done, the container is deployed to minikube. Keep in mind that if its necessary tio deply to Docker Hub, then rebuilding in a new shell without executing the `eval $(minikube docker-env)` will be required.


## Exposing ports using Minikube
This is one way of exposing ports within the cluster as external resources.  The other way is using Kubernetes port-forwarding.

Everything is locked down in minikube so need to run *minikube tunnel* in another window and keep it up.  This will let *loadbalancer* services pass through and get the IP of the localhost. After it runs you can do a `k get services -n veetee ` and it will show 127.0.0.1 as an endpoint.

### Exposing Ports using K8s port-forwarding

This was the technique I preferred to use. In another window type:

```.shell

k -n veetee port-forward svc/veeteeweb 8080 5005 5055

```
Note that `k` is an alias for kubectl in my .bashrc: *alias k='kubectl'*. It can be very tiring typeing out kubectl all the time.  You will not need to do this until after the Veetee service is deployed to the k8s cluster.