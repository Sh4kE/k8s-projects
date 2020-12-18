
## Installation
Instructions can be found [here](https://www.vaultproject.io/docs/platform/k8s/helm) and [here](https://learn.hashicorp.com/tutorials/vault/kubernetes-minikube?in=vault/kubernetes)
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

kubectl create namespace metrics
kubectl config set-context --current --namespace=metrics

helm install metrics -f values.yaml bitnami/metrics-server
```
