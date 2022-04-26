# K8s Folder

This folder will contain the deployment yaml for Veetee.  

The first thing to try would be to use the K8s installed as part of K8s.  
- [minikube](https://minikube.sigs.k8s.io/docs/start/) is a good way to start.

To run minikube just type `minikube start` after installing.

##Create the namespaces in the k8s cluster

```
kubectl apply -f prom_namespace.yaml
kubectl apply -f veetee_namespace.yaml

kubectl get namespace -A

```
You should see the namespaces list there. now:

```



```
