Install ArgoCD

```
helm upgrade --install \
  argocd argo-cd \
  --repo https://argoproj.github.io/argo-helm \
  --create-namespace \
  --namespace argocd \
  --wait
```

Apply the `app-of-apps`

```
kubectl apply -f https://raw.githubusercontent.com/ondrejsika/argocd-apps-public/refs/heads/master/clusters/k3s_kc2/_app_of_apps/app_of_apps.yml
```
