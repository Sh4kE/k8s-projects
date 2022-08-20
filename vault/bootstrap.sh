kubectl exec vault-0 -- vault operator init -key-shares=5 -key-threshold=3 -format=json > cluster-keys.wavestack.json

UNSEAL_TOKEN_0=$(jq -r ".unseal_keys_b64[0]" cluster-keys.wavestack.json)
UNSEAL_TOKEN_1=$(jq -r ".unseal_keys_b64[1]" cluster-keys.wavestack.json)
UNSEAL_TOKEN_2=$(jq -r ".unseal_keys_b64[2]" cluster-keys.wavestack.json)
UNSEAL_TOKEN_3=$(jq -r ".unseal_keys_b64[3]" cluster-keys.wavestack.json)
UNSEAL_TOKEN_4=$(jq -r ".unseal_keys_b64[4]" cluster-keys.wavestack.json)

ROOT_TOKEN=$(jq -r ".root_token" cluster-keys.wavestack.json)

kubectl exec vault-0 -- vault operator unseal $UNSEAL_TOKEN_0
kubectl exec vault-0 -- vault operator unseal $UNSEAL_TOKEN_1
kubectl exec vault-0 -- vault operator unseal $UNSEAL_TOKEN_2

kubectl exec -ti vault-1 -- vault operator raft join http://vault-0.vault-internal:8200
kubectl exec -ti vault-1 -- vault operator unseal $UNSEAL_TOKEN_0
kubectl exec -ti vault-1 -- vault operator unseal $UNSEAL_TOKEN_1
kubectl exec -ti vault-1 -- vault operator unseal $UNSEAL_TOKEN_2

kubectl exec -ti vault-2 -- vault operator raft join http://vault-0.vault-internal:8200
kubectl exec -ti vault-2 -- vault operator unseal $UNSEAL_TOKEN_0
kubectl exec -ti vault-2 -- vault operator unseal $UNSEAL_TOKEN_1
kubectl exec -ti vault-2 -- vault operator unseal $UNSEAL_TOKEN_2


kubectl exec --stdin=true --tty=true vault-0 -- /bin/sh
###############

vault login -address=https://vault.k3s.sh4ke.rocks $ROOT_TOKEN

vault secrets enable -path=kv kv-v2

vault auth enable kubernetes
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

vault policy write argocd - <<EOF
path "kv/data/k3s/argocd/*" {
  capabilities = ["read"]
}
EOF

vault write auth/kubernetes/role/argocd \
    bound_service_account_names="*" \
    bound_service_account_namespaces=argocd \
    policies=argocd \
    ttl=24h
