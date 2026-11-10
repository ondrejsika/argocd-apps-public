Install K3s without the built-in Traefik (Traefik is installed by ArgoCD and binds host ports 80 and 443)

```
curl -sfL https://get.k3s.io | sh -s - --disable traefik --disable local-storage
```

Set up kubectl

```
mkdir -p ~/.kube
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
chmod 600 ~/.kube/config
```

Install ArgoCD using Helm

```
helm upgrade --install argocd argo-cd --repo https://argoproj.github.io/argo-helm --create-namespace --namespace argocd --version 10.17.0 --wait
```

Apply from GitHub

```
kubectl apply -f https://raw.githubusercontent.com/ondrejsika/argocd-apps-public/refs/heads/master/clusters/cnpg_on_zfs/_app_of_apps/app_of_apps.yml
```
