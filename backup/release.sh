#!/bin/bash

set +euo pipefail
releaseType=$1
repo=$2
usage="usage: ./release.sh <major|minor|patch> <reponame>"

if [[ $# != 2 ]];then
  printf "expected 2 arguments got $#\n%s" "${usage}"
  exit 1
fi

if ! helm repo list | grep "${repo}" ;then
  printf "helm repo not found\n%s" "${usage}"
  exit 1
fi

version=$(grep '^version' Chart.yaml)
versionNum=$(echo "${version}" | cut --delimiter=" " -f2-)

IFS=. read -r major minor patch <<<"${versionNum}"
case "${releaseType}" in
  "major") _=$((major++))
           minor=0
           patch=0
  ;;
  "minor") _=$((minor++))
           patch=0
  ;;
  "patch") _=$((patch++))
  ;;
  *) echo "${usage}"
  ;;
esac

newVersion="version: ${major}.${minor}.${patch}"
sed -e "s/${version}/${newVersion}/" Chart.yaml -i

packagePath=$(helm package .| cut --delimiter=" " -f8-)
echo "releasing chart with ${newVersion}"
helm cm-push "${packagePath}" "${repo}"
