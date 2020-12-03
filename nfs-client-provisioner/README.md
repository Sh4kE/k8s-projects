## Installation
Instructions can be found [here](https://github.com/helm/charts/tree/master/stable/nfs-client-provisioner)
```
kubectl create namespace nfs-client-provisioner
kubectl config set-context --current --namespace=nfs-client-provisioner

helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install nfs-client-provisioner --set nfs.server=192.168.178.55 --set nfs.path=/mnt/NAS/k8s_storage stable/nfs-client-provisioner
```
