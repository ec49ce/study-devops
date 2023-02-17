#!/usr/bin/env bash

export TOPIC="Monitoring"
export DEPLOY_TYPE="$TOPIC demo app"
export DEPLOYDATE=$(date +%Y%m%d-%H%M)
export NAMESPACE="default"
export RELEASE_VER="${TOPIC,,}"
export GITHUB_REGISTRY_OWNER="dos11-onl"
export REGISTRY="ghcr.io/${GITHUB_REGISTRY_OWNER}"
export GITHUB_REGISTRY_SECRET="github-cred"
