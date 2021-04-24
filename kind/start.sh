#!/bin/bash

set -o errexit


# desired cluster name; default is "kind"
export KIND_CLUSTER_NAME="${KIND_CLUSTER_NAME:-operator-devl}"

# create registry container unless it already exists
reg_name='kind-registry'
reg_port='5000'


# kind delete cluster --name "${KIND_CLUSTER_NAME}"


# create a cluster with the local registry enabled in containerd
kind create cluster --name "${KIND_CLUSTER_NAME}" --config=kind/config.yaml

# connect the registry to the cluster network
# (the network may already be connected)
docker network connect "kind" "${reg_name}" || true

# Document the local registry
# https://github.com/kubernetes/enhancements/tree/master/keps/sig-cluster-lifecycle/generic/1755-communicating-a-local-registry
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:${reg_port}"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF

