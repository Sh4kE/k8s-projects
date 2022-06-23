kubectl exec vault-0 -- vault operator init -key-shares=5 -key-threshold=3 -format=json > cluster-keys.json

UNSEAL_TOKEN_0=$(jq -r ".unseal_keys_b64[0]" cluster-keys.json)
UNSEAL_TOKEN_1=$(jq -r ".unseal_keys_b64[1]" cluster-keys.json)
UNSEAL_TOKEN_2=$(jq -r ".unseal_keys_b64[2]" cluster-keys.json)
UNSEAL_TOKEN_3=$(jq -r ".unseal_keys_b64[3]" cluster-keys.json)
UNSEAL_TOKEN_4=$(jq -r ".unseal_keys_b64[4]" cluster-keys.json)

ROOT_TOKEN=$(jq -r ".root_token" cluster-keys.json)

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

    vault secrets enable -path=kv kv-v2
    vault kv put kv/k3s/argocd/config username="sh4ke" password="go sh4key go"

    vault auth enable kubernetes
    vault write auth/kubernetes/config \
        token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
        kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
        kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

    vault policy write argocd - <<EOF
path "kv/k3s/argocd/*" {
  capabilities = ["read"]
}
EOF

    vault write auth/kubernetes/role/argocd \
        bound_service_account_names=argocd-server \
        bound_service_account_namespaces=argocd \
        policies=argocd \
        ttl=24h

    vault auth enable approle

    vault write auth/approle/role/argocd \
        secret_id_ttl=10m \
        token_num_uses=10 \
        token_ttl=20m \
        token_max_ttl=30m \
        secret_id_num_uses=40

    vault read auth/approle/role/argocd/role-id | grep role_id | tr -s ' ' | cut -d ' ' -f 2

    # Get a SecretID issued against the argocd AppRole
    vault write -f auth/approle/role/argocd/secret-id



