Install K3s without Traefik (NGINX Gateway Fabric binds host ports 80 and 443)

```
curl -sfL https://get.k3s.io | sh -s - --disable traefik
```

Install ArgoCD using Helm

```
helm upgrade --install argocd argo-cd --repo https://argoproj.github.io/argo-helm --create-namespace --namespace argocd --version 10.17.0 --wait
```

Apply from GitHub

```
kubectl apply -f https://raw.githubusercontent.com/ondrejsika/argocd-apps-public/refs/heads/master/clusters/example_k3s_with_gw/_app_of_apps/app_of_apps.yml
```
