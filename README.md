# Virtual Teammate Veetee

## Introduction

*Veetee* is a chatbot engineered as a virtual assistant or virtual teammate. it is built with [rasa open source](https://rasa.com/open-source/). Rasa works on intentions, stories and actions.  When a user is typing something, the AI needs to determine the *intention*.  This alings with a *story*. What follows a story is an *action*.  This can be a simple response or a run of a python script.  

Rasa is very extensible and once an understanding of how it works was achieved a docker container followed by a Kubernetes deployment were constructed.

Note, while the objective of this project is to place a virtual assistant into a K8s cluster, fortunately development can be performed in a simple Python virtual environment. That is where one should start.

## Installing Rasa 

 - [Rasa Installation](./docs/installingRasa.md)

## Setting Up a Rasa project

 - [Set up a Rasa Project](./docs/SettingUpRasaProject.md)
 - [Rasa website Instructions](https://rasa.com/docs/rasa/installation/)

## Setting up a Minikube cluster

At this point, you should have a working rasa model and undestand some of the core aspects of working with Rasa.
