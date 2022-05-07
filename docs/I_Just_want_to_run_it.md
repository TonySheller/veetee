# I Just want to run it.

To simply run it, the following will need to be performed.

# Get and install Minikube

One can search the internet for this but the best resource is problably the [MiniKube getting started page](https://minikube.sigs.k8s.io/docs/start/). I used Linux, actually Windows, Sub-system for Linux 2 (WSL2) so followed the Linux instructions.

```.shell

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

```

## Minikube start

Just like that `minikube start` and *poof* a K8s cluster. OK, it's only one node but one can do alot of work with it.


## kubectl  get and installinstall

A `kubectl` should really be installed. This is one of the the main ways a K8s adminstrator works with a cluster. Following the instructions from the K8s [Install and Setup Kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/):

```.shell

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl

```


## Helm get and install

The [Helm download site on GitHub](https://github.com/helm/helm/releases) is a terrific resource. Download the version needed for your OS. [Linux amd64](https://get.helm.sh/helm-v3.8.1-linux-amd64.tar.gz) might be a good choice.

## Create the necessary namespace in the minikube cluster

These namespaces are needed for this project. 
In the K8s folder of this project type the following:

```
kubectl apply -f prometheus_namespace.yaml

kubectl apply -f veetee_namespace.yaml

```

## Using Helm to Install Prometheus

Helm is like yum, apt or rpm -- it's a package manager for K8s. It can make installing complex solutions, like Prometheus, very easy.  It also helps with 

```.shell

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus -n prometheus

```

## Now install the application
Both the deployment and service are defined in the one file.
Be sure to be in the k8s folder of this project
```.shell

kubectl -n veetee apply -f veetee-deployment.yaml 

```

## Forward the necessary ports from within K8s

Open up another shell and do the following:

```shell

kubectl -n veetee port-forward svc/veeteeweb 8080 5005 5055

```