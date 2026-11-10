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

URL=$(kubectl --context $MGMT_CONTEXT -n $CLUSTER_ID get clusterregistrationtokens.management.cattle.io default-token -o jsonpath='{.status.manifestUrl}')
if [ -z "$URL" ]; then
  echo "Cluster $CLUSTER ($CLUSTER_ID) has no import manifest URL (yet)" >&2
  exit 1
fi

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
