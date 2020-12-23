path "secret/" {
  capabilities = ["list"]
}

path "secret/puppet/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
