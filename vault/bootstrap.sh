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
