# Setting up Prometheus.
Prometheus is a a monitoring system used mostly for k8s or systems that use containers but it can be used for standalone hardware. One will need to have a K8s cluster setup. Fortunately, minikube is a good choice for things like this. 

## Minikube -- is it installed and running
A set of instruction on [Minikube Getting started](../docs/Minikube_getting_started.md) are provided. Please ensure your cluster is up and ready.

## Using Helm to Install Prometheus

Helm is like yum, apt or rpm -- it's a package manager for K8s. It can make installing complex solutions, like Prometheus, very easy.  It also helps with 

```.shell

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus -n prometheus
```

## Output from doing a helm install

Pay attention to this as much of it will come in handy down the road.

```
(RASA) asheller@DESKTOP-B3F18RF:/mnt/e/en705603/veetee/k8s$ helm install prometheus prometheus-community/prometheus -n prometheus
NAME: prometheus
LAST DEPLOYED: Sun Apr 24 16:14:51 2022
NAMESPACE: prometheus
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-server.prometheus.svc.cluster.local


Get the Prometheus server URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace prometheus -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace prometheus port-forward $POD_NAME 9090


The Prometheus alertmanager can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-alertmanager.prometheus.svc.cluster.local


Get the Alertmanager URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace prometheus -l "app=prometheus,component=alertmanager" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace prometheus port-forward $POD_NAME 9093
#################################################################################
######   WARNING: Pod Security Policy has been moved to a global property.  #####
######            use .Values.podSecurityPolicy.enabled with pod-based      #####
######            annotations                                               #####
######            (e.g. .Values.nodeExporter.podSecurityPolicy.annotations) #####
#################################################################################


The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
prometheus-pushgateway.prometheus.svc.cluster.local


Get the PushGateway URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace prometheus -l "app=prometheus,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace prometheus port-forward $POD_NAME 9091

For more information on running Prometheus, visit:
https://prometheus.io/
```