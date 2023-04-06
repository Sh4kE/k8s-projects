#!/boot/bash

GITEA_TOKEN=$1

user_id=$(curl -X "GET" "https://gitea.sh4ke.rocks/api/v1/user?access_token=$GITEA_TOKEN" -H "accept: application/json" | jq '.id')
echo "user id of sh4ke is: $user_id"

repos=$(curl -X 'GET' 'https://gitea.sh4ke.rocks/api/v1/repos/search?uid=2&access_token=***REMOVED***' -H 'accept: application/json' | jq -r '.data[] | .name')
echo $repos
