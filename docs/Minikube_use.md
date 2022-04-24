# Minikube Use 

Minikube is a preferred way to develop but can be trying at times.  

## Loading your images
Minikube can build your image and put it in your container or you can copy it over.  I copy mine from the local registry. it can take a while to load depending on the size of the image.  

```
minikube image load ashelle5/veetee:0.1
```

## To expose your services

Everything is locked down in minikube so need to run *minikube tunnel* in another window and keep it up.  This will let *loadbalancer* services pass through and get the IP of the localhost. After it runs you can do a `k get services -n veetee ` and it will show 127.0.0.1 as an endpoint.



