# Ingress-Nginx

## Installation
Instructions can be found [here](https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx)

```
kubectl create namespace ingress-nginx
kubectl config set-context --current --namespace=ingress-nginx

helm install ingress-nginx ingress-nginx/ingress-nginx

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
```
