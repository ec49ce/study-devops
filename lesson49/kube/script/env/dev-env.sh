#!/usr/bin/env bash

export DEPLOY_APPS=(mysql wordpress nginx)
export NAMESPACE="dev"

# LABELS
export PROJECT_LABEL="wordpress"
export VERSION_LABEL=$RELEASE_VER
export MYSQL_APP_LABEL="mysql"

# REPLICAS
export MYSQL_DEPLOY_REPLICA_COUNT=1

# CONTAINERS
export MYSQL_CONTAINER_NAME="mysql"
export MYSQL_CONTAINER_IMAGE="mysql:8.0.31"

# PORTS
export MYSQL_CONTAINER_PORT_NUMBER=3306
export MYSQL_CONTAINER_PORT_NAME="mysql"

# VOLUMES
export MYSQL_VOLUME_NAME="mysql-data"
export MYSQL_VOLUME_MOUNTS_PATH="/var/lib/mysql"

# PVC
export MYSQL_PVC_STORAGE_CLASS="standard-fast"
export MYSQL_PVC_SIZE="500Mi"