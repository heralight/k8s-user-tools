#!/usr/bin/env bash

source ./libs/script-args-checker-cluster-common.sh "$@"
source ./libs/set-user-as-common.sh ./templates/permissions-template-cluster-common.yaml edit  $1 $2 cluster

