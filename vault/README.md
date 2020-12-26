
## Installation
Instructions can be found [here](https://www.vaultproject.io/docs/platform/k8s/helm) and [here](https://learn.hashicorp.com/tutorials/vault/kubernetes-minikube?in=vault/kubernetes)
```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

kubectl create namespace vault
kubectl config set-context --current --namespace=vault

kubectl apply -f certificates.yaml

helm install vault -f values.yaml hashicorp/vault
```

#### Vault initialization and unsealing
```
kubectl port-forward vault-0 8200:8200

kubectl exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json
VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")
kubectl exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
```

#### Enable Kubernetes authentication
```
kubectl exec vault-0 -- /bin/sh
$ vault login
$ vault auth enable kubernetes
$ vault write auth/kubernetes/config \
        token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
        kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
        kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

### AppRole
```
vault auth enable approle
```

#### Create policies
```
vault policy write hiera hcl/hiera.hcl
vault policy write hiera-operator hcl/hiera-operator.hcl
```

#### Explicitly create a token with a policy


```
vault token create -policy=hiera
```

#### Create Hiera role with assigned policy
```
vault write auth/approle/role/hiera token_policies="hiera"
```
Tokens created from this role will have the specified policy attached

```
vault read auth/approle/role/hiera/role-id
vault write -f auth/approle/role/hiera/secret-id
```
Use the role-id and secret-id to generate a new token
