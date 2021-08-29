## Manual Installation
```commandline
kubectl create namespace argocd
kubectl config set-context --current --namespace=argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Or via ArgoCD Application
```commandline
kubectl apply -n argocd -f application.yaml
```
