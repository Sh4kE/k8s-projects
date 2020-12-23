# Gitea

# Installtion
Instructions can be found [here](https://artifacthub.io/packages/helm/cronce/bitwarden-rs)

```
helm repo add cronce https://charts.cronce.io/
helm repo update

kubectl create namespace bitwarden
kubectl config set-context --current --namespace=bitwarden

kubectl apply -f certificates.yaml

helm install bitwarden -f values.yaml cronce/bitwarden-rs
```
