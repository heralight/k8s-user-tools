# Kubernetes ServiceAccount Rights Tools

## Goals

Kubernetes don't have real "user", and it's difficult to provide access to a kubernetes cluster to person without sharing your kubeconfig, it's a very bad practice.
When you use a bare metal kubernetes cluster or Kubernetes cluster managed by OVH or Scaleway, you don't any interface or simple to administrate your cluster permissions.

These tools are to simplify the creation of a ServiceAccount and create a kubeconfig.yaml for this account.
In a second step, apply some permissions to this ServiceAccount.
## Origin

script was inspired from https://gist.github.com/xtavras/98c6a2625079a78054a907219c976e2b and https://gist.github.com/innovia/fbba8259042f71db98ea8d4ad19bd708 and adjusted with "apply_rbac" function and colorized output.

## Create a user service-account for a namespace

```sh
./add-user.sh serviceaccountname namespace-of-your-svc
```

## Command examples

### Set a user  as cluster admin

```sh
./set-user-as-cluster-admin.sh serviceaccountname namespace-of-your-svc
```

### Set a user for a namespace as admin

```sh
./set-user-as-ns-admin.sh serviceaccountname namespace-of-your-svc your-targeted-namespace
```

### Test your configuration

```sh
kubectl  --kubeconfig=./tmp/kube/k8s-xxxxx.yaml get ns
```

## Garanties

The code is provide as is without any garanties or support. 
Up to you to check, verify, enforce, fix any security problems.

## Licence

