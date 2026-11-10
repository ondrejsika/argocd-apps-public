#!/bin/sh
# Generate Secret with Rancher import manifest URL for an imported cluster
#
# Usage:
#   ./docs/rancher/import_url.sh <cluster> | kubectl --context <target-cluster> apply -f -
#
# URL is read from the k3s_mgmt cluster using kubectl context k3s-mgmt
# (override with MGMT_CONTEXT env variable)

set -e

CLUSTER=$1
MGMT_CONTEXT=${MGMT_CONTEXT:-k3s-mgmt}

if [ -z "$CLUSTER" ]; then
  echo "Usage: $0 <k3s-dev|k3s-test>" >&2
  exit 1
fi

CLUSTER_ID=$(kubectl --context $MGMT_CONTEXT -n fleet-default get clusters.provisioning.cattle.io $CLUSTER -o jsonpath='{.status.clusterName}')
if [ -z "$CLUSTER_ID" ]; then
  echo "Cluster $CLUSTER in context $MGMT_CONTEXT has no cluster ID (yet)" >&2
  exit 1
fi

# Rancher 2.15 keeps the registration token in a Secret, status.manifestUrl
# contains only a {token} placeholder, so build the URL the same way as Rancher
# <server-url>/v3/import/<token>_<cluster-id>.yaml
SERVER_URL=$(kubectl --context $MGMT_CONTEXT get settings.management.cattle.io server-url -o jsonpath='{.value}')
if [ -z "$SERVER_URL" ]; then
  echo "Rancher server-url is not set (yet), log in to Rancher first" >&2
  exit 1
fi

TOKEN_SECRET=$(kubectl --context $MGMT_CONTEXT -n $CLUSTER_ID get clusterregistrationtokens.management.cattle.io default-token -o jsonpath='{.status.tokenSecretName}')
if [ -z "$TOKEN_SECRET" ]; then
  echo "Cluster $CLUSTER ($CLUSTER_ID) has no registration token (yet)" >&2
  exit 1
fi

TOKEN=$(kubectl --context $MGMT_CONTEXT -n $CLUSTER_ID get secret $TOKEN_SECRET -o jsonpath='{.data.token}' | base64 -d)
if [ -z "$TOKEN" ]; then
  echo "Secret $TOKEN_SECRET in $CLUSTER_ID has no token (yet)" >&2
  exit 1
fi

URL="${SERVER_URL%/}/v3/import/${TOKEN}_${CLUSTER_ID}.yaml"

cat <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: rancher-agent-import
---
apiVersion: v1
kind: Secret
metadata:
  name: rancher-import
  namespace: rancher-agent-import
type: Opaque
stringData:
  url: $URL
YAML
