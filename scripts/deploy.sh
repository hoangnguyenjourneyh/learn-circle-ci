#!/usr/bin/env bash

set -e

source ./scripts/set_environment.sh

docker build -t ${AWS_ECR_REPO_URL} .

echo -e "${COLOR}::::login aws::::${NC}"

aws ecr get-login-password --region ${AWS_INSTANCE_REGION} | docker login --username AWS --password-stdin 826423024318.dkr.ecr.ap-southeast-2.amazonaws.com

echo -e "${COLOR}::::pushing to aws repo::::${NC}"
docker push ${AWS_ECR_REPO_URL}