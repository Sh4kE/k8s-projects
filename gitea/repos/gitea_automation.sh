#!/bin/bash

GITEA_TOKEN=$1

repos=$(curl -s -X "GET" "https://gitea.sh4ke.rocks/api/v1/user/repos?access_token=$GITEA_TOKEN" -H "accept: application/json" | jq -r ".[] | .name")
for repo in $repos; do
    echo "$repo"
    curl -s -X 'POST' \
      "https://gitea.sh4ke.rocks/api/v1/repos/sh4ke/$repo/push_mirrors?access_token=$GITEA_TOKEN" \
      -H "accept: application/json" \
      -H "Content-Type: application/json" \
      -d "{
          \"interval\": \"8h0m0s\",
          \"remote_address\": \"https://gitea.ws.sh4ke.rocks/sh4ke/$repo.git\",
          \"remote_password\": \"$GITEA_TOKEN\",
          \"remote_username\": \"sh4ke\",
          \"sync_on_commit\": true
        }"
done
