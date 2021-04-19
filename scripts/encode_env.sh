#!/usr/bin/env bash

set -e

source ./scripts/set_environment.sh

echo "npm-debug.log\nyarn-error.log" > .dockerignore
export AWS_PRIVATE_KEY_PATH='permission.pem'
cp Dockerfile_ci Dockerfile

if [[ "$CIRCLE_BRANCH" == "master" ]] || [[ "$CIRCLE_BRANCH" == "production" ]] ; then
  # todo: set up aws credentials for getting the env file
  mkdir ~/.aws
  touch ~/.aws/config
  touch ~/.aws/credentials

  echo "[profile environment]" >> ~/.aws/config
  echo "[environment]" >> ~/.aws/credentials
  echo "aws_access_key_id = ${AWS_ENV_USER_ACCESS_KEY_ID}" >> ~/.aws/credentials
  echo "aws_secret_access_key = ${AWS_ENV_USER_SECRET_ACCESS_KEY}" >> ~/.aws/credentials

  aws secretsmanager get-secret-value --secret-id ${AWS_ENV_SECRET_NAME} --query SecretString --output text --profile=environment > .env.json
  ./scripts/json2env.sh .env.json .env

  cat .env
  echo "---------------\n"
  cat ~/.aws/credentials
  echo "---------------\n"
  cat ~/.aws/config

fi