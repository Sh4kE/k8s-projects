# Monitoring the Kubernetes Cluster

## Installation
Instructions can be found [here](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack)
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update

kubectl create namespace kubernetes-dashboard
kubectl config set-context --current --namespace=kube-prometheus

kubectl apply -f certificates.yaml

helm install kube-prometheus -f values.yaml prometheus-community/kube-prometheus-stack
``` 
