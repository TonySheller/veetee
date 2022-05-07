# Virtual Teammate Veetee

## Introduction

*Veetee* is a virtual assistant or teammate and is built with [rasa open source](https://rasa.com/open-source/). 
In reviewing options it was determined that Rasa was the most complete and feature-rich natural language understanding (NLU) framework available. The objective of Veetee is to run in a Kubernetes (K8s) cluster and perform actions for administrators and users. The example detailed in this project contains everything to:

0. Project overview
1. Contruct a Rasa virtual teammate or assitant of your own.
2. Craft the intentions, stories and actions needed to train the virtual teammate.
3. Containerize the virtual teammate.
4. Setup a K8s cluster using MiniKube. This is a one node (physical server) cluster.
5. Install Prometheus (cluster monitoring) using a Helm chart.
6. Build a K8s deployment and service for Veetee so that it can be deployed to the cluster.
7. Deploy Veetee to the cluster.
8. Forward the internal ports of Veetee so that it can be "chatted" with in a web-browser.

Rasa uses three key concepts that embody it very well: intentions, stories and actions.  When a user is typing something, the AI needs to determine the  users *intention*.  This aligns with a *story*. *Stories* contain *actions* which is what the virtual teammate is performing. This can be a simple reply in the form of simple text or a summary of information obtained through database queries or the execution of python scripts.  

Rasa is very extensible and once an understanding of how it works was achieved a docker container that wrapped up teh model was constrcuted. This was followed by the creaation ofollowed by a Kubernetes deployment were constructed.

Note, while the objective of this project is to place a virtual assistant into a K8s cluster, fortunately development can be performed in a simple Python virtual environment. That is where one should start.


## Project Overview

The contents of this project will be explained in this section to ensure a clear understanding as to what each file and directory's purpose is understood.

- `Dockerfile` -- This is the file used by Docker to containerize Veetee. Please review its contents. The container is intended to provide enough resources that a developer can access it and work in the container.
- `runVeetee.sh` -- This is a shell script that will run the docker container created. It can be modified to suite whatever naming convention needed.
- `trainrasa.sh` -- This shell script is copied into the docker container and is run to train the Rasa model.
- `entrypoint.sh` -- This shell script is also copied over and when the container launches or is run, it starts up the Nginx web server, the Rasa action server, and the Rasa Server itself.
- `LICENSE` -- A license file, which some projects require -- but here its proclaiming, this is free and open source under the GNU GENERAL PUBLIC LICENSE.
- `docs folder` -- Contains markdown documentation for specific topics such as setting up Minikube and Prometheus.
- `k8s` -- This folder contains the necessary YAML files used to deploy the Virtual Teammate (Veetee) to a K8s cluster.
- `rasa` -- This folder is the Rasa environment. It contains the necessary software to provide the service.
## Construct a Rasa Virtual Teammate or Assistant of your own

While this project, Veetee, already comes with a rasa project setup, instructions are provided for setting up a new one are provided. This provides the context around how one might get started with their own project. 

 - [Rasa Software Installation](./docs/installingRasa.md)

These are the instructions for working with a project of your own.

 - [Set up a Rasa Project](./docs/SettingUpRasaProject.md)

 Here are the instructions from Rasa's website that provide better context. 
 - [Rasa website Instructions](https://rasa.com/docs/rasa/installation/)


## Crafting the intentions, stories, and actions of your virtual assistant (teammate)

Rasa will take a users intent and match it up with the most likely story and then execute some sort of action. That's the general *flow of control*. The *intention* of the user is to get the storage of a K8s cluster. This will match up with a story and an action will be performed that will query Prometheus, a K8s monitoring system, for information on the filesystems.  This will be compiled and presented back to the user.  

- [Setting up a Rasa Scenario](./docs/SettingUpScenario.md)


## Containerize the virtual teammate.
The dockerfile provided at the base of this project will containerize the rasa project just built and when Run launch the services necessary to use it as a service in a K8s cluster. Run the following command to build the docker container.

```
docker build --no-cache -t ashelle5/veetee:1.0 .
```

## Setting up a Minikube cluster

At this point, you should have a working rasa model and undestand some of the core aspects of working with Rasa. As well as being able to build your cluster. The next step will be to deploy it in a K8s cluster to work with, but first setting up a K8s cluster will need to be performed.

- [Getting Started with Minikube](./docs/Minikube_getting_started.md)


## Create the necessary namespaces
Two namespaces will be used for this project. Change into the K8s folder and crate them like this:

```.shell

kubectl apply -f prometheus_namespace.yaml

kubectl apply -f veetee_namespace.yaml

```


## Install Prometheus

Now install Prometheus into the cluster using helm.

[Prometheus Setup](./docs/PrometheusSetup.md)


##  Now Install the application
Be sure to change into the k8s folder where the K8s yaml files are.


```.shell

kubectl -n veetee apply -f veetee-deployment.yaml 

```

## Forward the necessary ports from within K8s

Open up another shell and do the following:


```shell

kubectl -n veetee port-forward svc/veeteeweb 8080 5005 5055



```