#!/bin/sh
# Generate kubeconfig Secret for a Kargo controller (shard) from its ServiceAccount token
#
# Usage:
#   ./docs/kargo/controller_kubeconfig.sh <shard> <mgmt-api-server-url> | kubectl --context <target-cluster> apply -f -
#
# Token is read from the k3s_mgmt cluster using kubectl context k3s-mgmt
# (override with MGMT_CONTEXT env variable)

set -e

SHARD=$1
SERVER=$2
MGMT_CONTEXT=${MGMT_CONTEXT:-k3s-mgmt}

if [ -z "$SHARD" ] || [ -z "$SERVER" ]; then
  echo "Usage: $0 <dev|test|prod> <mgmt-api-server-url>" >&2
  exit 1
fi

SECRET=kargo-controller-$SHARD-token
TOKEN=$(kubectl --context $MGMT_CONTEXT -n kargo get secret $SECRET -o jsonpath='{.data.token}')
CA=$(kubectl --context $MGMT_CONTEXT -n kargo get secret $SECRET -o jsonpath='{.data.ca\.crt}')

if [ -z "$TOKEN" ] || [ -z "$CA" ]; then
  echo "Secret $SECRET in context $MGMT_CONTEXT has no token (yet)" >&2
  exit 1
fi

TOKEN=$(echo $TOKEN | base64 -d)

cat <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: kargo
---
apiVersion: v1
kind: Secret
metadata:
  name: kargo-control-plane-kubeconfig
  namespace: kargo
type: Opaque
stringData:
  kubeconfig.yaml: |
    apiVersion: v1
    kind: Config
    clusters:
      - name: k3s-mgmt
        cluster:
          server: $SERVER
          certificate-authority-data: $CA
    users:
      - name: kargo-controller-$SHARD
        user:
          token: $TOKEN
    contexts:
      - name: k3s-mgmt
        context:
          cluster: k3s-mgmt
          user: kargo-controller-$SHARD
    current-context: k3s-mgmt
YAML
