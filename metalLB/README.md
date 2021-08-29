# Monitoring the Kubernetes Cluster

## Installation
Instructions can be found [here](https://metallb.universe.tf/installation/)
```
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb
helm repo update

kubectl create namespace metallb
kubectl config set-context --current --namespace=metallb

helm install metallb metallb/metallb -f values.yaml
``` 

## Configuration
Configure a static route to the chosen network-CIDR (192.168.179.0/24) to point to the host running the MetalLB.

```
Heimnetz -> Netzwerk -> Netzwerkeinstellungen -> weitere Einstellungen
```

The host will be called via the ARP Protocol, which means it does not need 
to have a real interface with the same netwrok address.

## Usage
You can now start deploying services of type `LoadBalancer`, which will automatically assign an IP 
from the chosen address range as the external IP to the service.   
