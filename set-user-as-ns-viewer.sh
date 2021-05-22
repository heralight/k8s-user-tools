#!/usr/bin/env bash

source ./libs/script-args-checker-ns-common.sh "$@"
source ./libs/set-user-as-common.sh ./templates/permissions-template-ns-common.yaml view  "$@"
