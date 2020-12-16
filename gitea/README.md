# Gitea

# Installtion
Instructions can be found [here](https://artifacthub.io/packages/helm/gitea/gitea)

```
helm repo add gitea-charts https://dl.gitea.io/charts/
helm repo update

kubectl create namespace gitea
kubectl config set-context --current --namespace=gitea

kubectl apply -f certificates.yaml

helm install gitea -f values.yaml gitea-charts/gitea
```
