#!/bin/sh

PROFILE="postgresql"

echo "This script requires this example's app to have been compiled with 'mvn clean package -Pcontainer,<db_type>'"
echo "==="

PROJECT_VERSION=$(cd ../ && mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

if [ -n "$1" ]; then
  if [ "$1" = "postgresql" ] || [ "$1" = "mssql" ]; then
    PROFILE="$1"
    echo "Using profile '${PROFILE}'..."
  else
    echo "Unknown docker profile '$1'. The supported profiles are: postgresql and mssql"
    exit 1;
  fi
else
  echo "No profile specified. Using default profile '${PROFILE}'..."
fi

echo "PROJECT_VERSION=${PROJECT_VERSION}" > ".env"

if [ "$(uname)" = "Darwin" ]; then
   echo "DOCKER_GATEWAY_HOST=kubernetes.docker.internal" >> ".env"
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
   echo "DOCKER_GATEWAY_HOST=172.17.0.1" >> ".env";
else
   echo "Unknown uname: $(uname)"
   exit 1
fi

docker compose -f docker-compose-${PROFILE}.yml up
