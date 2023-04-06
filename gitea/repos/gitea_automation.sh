#!/bin/bash

GITEA_TOKEN=$1

repos=$(curl -s -X "GET" "https://gitea.sh4ke.rocks/api/v1/user/repos?access_token=$GITEA_TOKEN" -H "accept: application/json" | jq -r ".[] | .name")
for repo in $repos; do
    echo "$repo"
    remotes=$(curl -s -X "GET" "https://gitea.sh4ke.rocks/api/v1/repos/sh4ke/$repo/push_mirrors?access_token=$GITEA_TOKEN" -H "accept: application/json" | jq -r ".[] | .remote_address")
    found_gitea_ws=false
    for remote in $remotes; do
        echo "found remote: $remote"
        if [[ "$remote" == *"https://gitea.ws.sh4ke.rocks/sh4ke/$repo.git"* ]]; then
            found_gitea_ws=true
        fi
    done
    if [ "$found_gitea_ws" = false ] ; then
        echo "need to add remote for repo $repo"
    fi
done
