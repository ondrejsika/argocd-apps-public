Install RKE2 without the built-in ingress controller (Traefik binds host ports 80 and 443)

```
mkdir -p /etc/rancher/rke2
cat <<EOF > /etc/rancher/rke2/config.yaml
ingress-controller: none
EOF
curl -sfL https://get.rke2.io | sh -
systemctl enable --now rke2-server.service
```

Set up kubectl

```
mkdir -p ~/.kube
cp /etc/rancher/rke2/rke2.yaml ~/.kube/config
chmod 600 ~/.kube/config
ln -s /var/lib/rancher/rke2/bin/kubectl /usr/local/bin/kubectl
```

Install ArgoCD using Helm

```
helm upgrade --install argocd argo-cd --repo https://argoproj.github.io/argo-helm --create-namespace --namespace argocd --version 10.17.0 --wait
```

Apply from GitHub

```
kubectl apply -f https://raw.githubusercontent.com/ondrejsika/argocd-apps-public/refs/heads/master/clusters/example_rke2_with_traefik/_app_of_apps/app_of_apps.yml
```
