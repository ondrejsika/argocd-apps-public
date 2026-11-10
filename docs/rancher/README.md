# Import Clusters to Rancher

Clusters `k3s-dev` and `k3s-test` are created in Rancher (`k3s_mgmt`) by ArgoCD, the agent is installed by ArgoCD in each cluster (`_cluster/rancher_agent`) using the import manifest URL from the Secret below

```
./docs/rancher/import_url.sh k3s-dev | kubectl apply --context k3s-dev -f -
./docs/rancher/import_url.sh k3s-test | kubectl apply --context k3s-test -f -
```

The import Job waits until the Secret exists, if it fails, resync the `rancher-agent` app in ArgoCD

Or save the Secrets to Git and let ArgoCD apply them (`rancher-agent` app syncs the `manifests` directory). It is a test setup, so it is fine to commit them, but the URL contains the registration token which can import a cluster into Rancher

```
./docs/rancher/import_url.sh k3s-dev > clusters/k3s_dev/_cluster/rancher_agent/manifests/secret.yaml
./docs/rancher/import_url.sh k3s-test > clusters/k3s_test/_cluster/rancher_agent/manifests/secret.yaml

git add clusters/k3s_dev/_cluster/rancher_agent/manifests/secret.yaml
git commit -m "feat(k3s_dev/rancher_agent): Add Rancher import Secrets"
git add clusters/k3s_test/_cluster/rancher_agent/manifests/secret.yaml
git commit -m "feat(k3s_test/rancher_agent): Add Rancher import Secrets"
git push
```

The registration token expires after 30 days, regenerate the Secrets if you import the clusters later
