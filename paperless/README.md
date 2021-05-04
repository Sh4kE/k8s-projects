# Gitea

# Installtion
Instructions can be found [here](https://artifacthub.io/packages/helm/k8s-at-home/paperless)

```
helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update

kubectl create namespace paperless
kubectl config set-context --current --namespace=paperless

kubectl apply -f certificates.yaml

helm install paperless -f values.yaml k8s-at-home/paperless
```
