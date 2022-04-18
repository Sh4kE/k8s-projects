## Manual Installation
```commandline
kubectl create namespace argocd
kubectl config set-context --current --namespace=argocd

kubectl apply -n argocd -f manifests/install.yaml
```

## Or via ArgoCD Application
```commandline
kubectl create namespace argocd
kubectl config set-context --current --namespace=argocd

kubectl apply -n argocd -f application.yaml
```

## add known hosts entry for my git
Hab ich aber per UI eingefügt!!!
```
ssh-keyscan git.sh4ke.rocks | argocd cert add-ssh --batch
```
