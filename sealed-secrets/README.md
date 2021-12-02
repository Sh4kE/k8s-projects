# Sealed secrets

```commandline
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
```

## How to retrieve the public key
The public key can be safely stored in Git, and can be used to encrypt secrets without direct access to the Kubernetes cluster.
```commandline
kubeseal --fetch-cert --controller-name=sealed-secrets --controller-namespace=sealed-secrets
```

## How to seal secrets
```commandline
kubeseal --format=yaml --cert=pub-sealed-secrets.pem < my-secret.yaml > my-sealed-secret.yaml
```
