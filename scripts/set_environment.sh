#!/usr/bin/env bash

set -e

export COLOR='\033[0;32m'
export NC='\033[0m'
export ERR='\033[0;31m'

export AWS_PROFILE_PARAM=''

export AWS_ENV_SECRET_NAME='tutorkoala/web/test'
export TAG_NAME=${TAG:-"latest-$(git rev-parse HEAD)"}
export AWS_PRIVATE_KEY_PATH='permission.pem'
export AWS_ECR_REPO_URL="826423024318.dkr.ecr.ap-southeast-2.amazonaws.com/tutorkoala-test:${TAG_NAME}"
export AWS_INSTANCE_REGION='ap-southeast-2'