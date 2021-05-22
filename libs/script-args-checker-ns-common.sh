#!/usr/bin/env bash
set -e
set -o pipefail

# Colors
RED="\e[01;31m"
GREEN="\e[01;32m"
YELLOW="\e[01;33m"
BLUE="\e[01;34m"
COLOROFF="\e[00m"

# Add user to k8s using service account
if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]]; then
 echo -e "Tool for namespace level."
 echo -e "usage:${BLUE} $0 ${GREEN}<service_account_name> <service_account_namespace> <targeted_namespace>${COLOROFF}"
 exit 1
fi
