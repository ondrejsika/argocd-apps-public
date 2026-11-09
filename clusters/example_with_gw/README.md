Install ArgoCD using Helm

```
helm upgrade --install argocd argo-cd --repo https://argoproj.github.io/argo-helm --create-namespace --namespace argocd --version 10.17.0 --wait
```

Apply from GitHub

```
kubectl apply -f https://raw.githubusercontent.com/ondrejsika/argocd-apps-public/refs/heads/master/clusters/example_with_gw/_app_of_apps/app_of_apps.yml
```
