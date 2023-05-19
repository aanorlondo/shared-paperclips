#!/bin/bash

# backend
export MONGO_USERNAME="username"
export MONGO_PASSWORD="password"
export MONGO_URL="host.docker.internal:27017"
export MONGO_DB_NAME="clipboards"
export MONGO_COLLECTION_NAME="entries"
export BACKEND_PORT="8080"

# frontent
export BACKEND_HOST="localhost:8080"
export BACKEND_ROUTE="clipboards"