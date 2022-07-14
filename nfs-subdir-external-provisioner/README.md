## Installation
Instructions can be found [here](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/tree/master/charts/nfs-subdir-external-provisioner)
```
kubectl create namespace nfs-client-provisioner
kubectl config set-context --current --namespace=nfs-client-provisioner

helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm repo update

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.178.55 \
    --set nfs.path=/mnt/NAS/k8s_storage
```
