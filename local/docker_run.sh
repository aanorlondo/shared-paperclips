#!/bin/bash

# clean first
docker rm -f CLIPBOARDS-MONGO-LOCAL
docker rm -f CLIPBOARDS-BACKEND-LOCAL
docker rm -f CLIPBOARDS-FRONTEND-LOCAL

export MONGO_USERNAME="username"
export MONGO_PASSWORD="password"
export MONGO_URL="host.docker.internal:27017"
export MONGO_DB_NAME="clipboards"
export MONGO_COLLECTION_NAME="entries"

export BACKEND_HOST="localhost"
export BACKEND_PORT="8080"
export BACKEND_ROUTE="clipboards"


# run the mongo db
docker run \
    -d \
    -p 27017:27017 \
    -e MONGO_INITDB_ROOT_USERNAME=$MONGO_USERNAME \
    -e MONGO_INITDB_ROOT_PASSWORD=$MONGO_PASSWORD \
    -e MONGO_INITDB_DATABASE=$MONGO_DB_NAME \
    -e MONGO_COLLECTION_NAME=$MONGO_COLLECTION_NAME \
    --name CLIPBOARDS-MONGO-LOCAL \
    negan/clipboard-mongo:local


# run the backend app
docker run \
    -d \
    -p 8080:8080 \
    -e MONGO_USERNAME=$MONGO_USERNAME \
    -e MONGO_PASSWORD=$MONGO_PASSWORD \
    -e MONGO_URL=$MONGO_URL \
    -e MONGO_DB_NAME=$MONGO_DB_NAME \
    -e MONGO_COLLECTION_NAME=$MONGO_COLLECTION_NAME \
    -e BACKEND_PORT=$BACKEND_PORT \
    -e BACKEND_ROUTE=$BACKEND_ROUTE \
    --name CLIPBOARDS-BACKEND-LOCAL \
    negan/clipboard-back:local


# run the frontend app
docker run \
    -d \
    -p 80:80 \
    -e BACKEND_HOST=$BACKEND_HOST \
    -e BACKEND_PORT=$BACKEND_PORT \
    -e BACKEND_ROUTE=$BACKEND_ROUTE \
    --name CLIPBOARDS-FRONTEND-LOCAL \
    negan/clipboard-front:local