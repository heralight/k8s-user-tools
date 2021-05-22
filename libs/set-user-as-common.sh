#!/usr/bin/env bash

# script was taken from https://gist.github.com/innovia/fbba8259042f71db98ea8d4ad19bd708 and adjusted with "apply_rbac" function and colorized output 


set -e
set -o pipefail

# Colors
RED="\e[01;31m"
GREEN="\e[01;32m"
YELLOW="\e[01;33m"
BLUE="\e[01;34m"
COLOROFF="\e[00m"

# Add user to k8s using service account
if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]] || [[ -z "$4" ]] || [[ -z "$5" ]]; then
 echo "usage: $0 <template_file> <role> <service_account_name> <service_account_namespace> <targeted_namespace> "
 echo "role must match: https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles"
 exit 1
fi

# Mode: admin, edit, view, ...etc: must match permissions-template-ns-*.yaml
TEMPLATE_FILE="$1"
ROLE=$2
SERVICE_ACCOUNT_NAME=$3
NAMESPACE="$4"
TARGET_NAMESPACE="$5"

KUBECFG_FILE_NAME="./tmp/kube/k8s-${SERVICE_ACCOUNT_NAME}-${NAMESPACE}-conf.yaml"
TARGET_FOLDER="./tmp/kube"

create_target_folder() {
    echo -e -n ${BLUE}"Creating target directory to hold files in ${TARGET_FOLDER}..."${COLOROFF}
    mkdir -p "${TARGET_FOLDER}"
    echo -e -n ${BLUE}"done"${COLOROFF}
}

apply_rbac() {
    target_file_name=permissions-${TARGET_NAMESPACE}-${ROLE}-${NAMESPACE}_${SERVICE_ACCOUNT_NAME}.yaml
    file_path=${TARGET_FOLDER}/${target_file_name} 
    echo -e -n ${BLUE}"\\nGeneration RBAC permissions file..."${COLOROFF}
    sed -e "s|my_account|${SERVICE_ACCOUNT_NAME}|g"\
     -e "s|my_namespace|${NAMESPACE}|g"\
     -e "s|target_namespace|${TARGET_NAMESPACE}|g"\
     -e "s|my_role|${ROLE}|g"\
    ${TEMPLATE_FILE} > ${file_path}
    echo -e ${BLUE}"\\nApplying RBAC permissions from ${file_path}"${COLOROFF}
    kubectl apply -f ${file_path}
    echo -e -n ${BLUE}"done"${COLOROFF}
}

create_target_folder
apply_rbac

echo -e "\\nAll done! Test with:"
echo -e ${YELLOW} "KUBECONFIG=${KUBECFG_FILE_NAME} ${COLOROFF} kubectl get pods"
KUBECONFIG=${KUBECFG_FILE_NAME} kubectl get pods
