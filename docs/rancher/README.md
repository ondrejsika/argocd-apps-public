# Import Clusters to Rancher

Clusters `k3s-dev` and `k3s-test` are created in Rancher (`k3s_mgmt`) by ArgoCD, the agent is installed by ArgoCD in each cluster (`_cluster/rancher_agent`) using the import manifest URL from the Secret below

```
./docs/rancher/import_url.sh k3s-dev | kubectl apply --context k3s-dev -f -
./docs/rancher/import_url.sh k3s-test | kubectl apply --context k3s-test -f -
```

The import Job waits until the Secret exists, if it fails, resync the `rancher-agent` app in ArgoCD
