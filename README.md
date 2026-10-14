> [!TIP]
> <a href="https://ondrej-sika.cz/skoleni/argocd"><img src="https://img.shields.io/badge/Školení%20ArgoCD-by%20Ondřej%20Šika-orange?style=for-the-badge&logo=argo&logoColor=white" style="width: 100%; height: auto;" alt="Školení ArgoCD by Ondřej Šika" /></a>
>
> 🚀 Naučte se, jak efektivně spravovat deploymenty pomocí **ArgoCD**! Praktické školení vedené [Ondřejem Šikou](https://ondrej-sika.cz).
>
> 👉 [Více informací a registrace zde](https://ondrej-sika.cz/skoleni/argocd)

# Ondrej Sika's ArgoCD Apps Public

## Setup

Install ArgoCD (using Helm) and deploy app-of-apps (ArgoCD Application)

### panda cluster

```sh
make setup_panda
```

### sikademo cluster

```sh
make setup_sikademo
```

### example cluster (k8s.sikademo.com)

```sh
make setup_example
```

or

```
kubectl apply -f https://raw.githubusercontent.com/ondrejsika/argocd-apps-public/refs/heads/master/clusters/example/_app_of_apps/app_of_apps.yml
```

### example_lab0 cluster

```sh
make setup_example_lab0
```

### rke2 cluster

```sh
make setup_example_rke2
```

### elastic cluster (elastic.sikademo.com)

```sh
make setup_elastic
```

or

```
kubectl apply -f https://raw.githubusercontent.com/ondrejsika/argocd-apps-public/refs/heads/master/clusters/elastic/_app_of_apps/app_of_apps.yml
```
