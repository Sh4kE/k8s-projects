# Certbot

## Installation
Instructions can be found [here](https://cert-manager.io/docs/installation/kubernetes/#installing-with-helm)

```
kubectl create namespace cert-manager
kubectl config set-context --current --namespace=cert-manager

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.5.2 \
  --set installCRDs=true

kubectl apply -f cluster-issuer-prod.yaml
```
