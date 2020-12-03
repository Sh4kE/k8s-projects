# Kubernetes Dashboard

### Installation
```
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update

kubectl create namespace kubernetes-dashboard
kubectl config set-context --current --namespace=kubernetes-dashboard

helm install kubernetes-dashboard -f values.yaml kubernetes-dashboard/kubernetes-dashboard
kubectl apply -f admin.yaml
```

### Usage

```
export TOKEN_NAME=$(kubectl get secret | grep admin-user-token | awk '{print $1}')
kubectl get secret $TOKEN_NAME -n kubernetes-dashboard -o jsonpath='{.data.token}' | base64 -d

export POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
kubectl -n kubernetes-dashboard port-forward $POD_NAME 8443:8443
```

Now go to https://127.0.0.1:8443 and login via token with the secret from above 
