# Ingress-Nginx

## Installation
Instructions can be found [here](https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx)

```
kubectl create namespace traefik
kubectl config set-context --current --namespace=traefik

helm repo add traefik https://helm.traefik.io/traefik
helm repo update

helm install traefik -f values.yaml traefik/traefik
```
