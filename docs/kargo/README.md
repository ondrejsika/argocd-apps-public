# Generate Kargo Controller Kubeconfig

```
./docs/kargo/controller_kubeconfig.sh dev https://k3s-mgmt.sikademo.com:6443 | kubectl apply --context k3s-dev -f -
./docs/kargo/controller_kubeconfig.sh test https://k3s-mgmt.sikademo.com:6443 | kubectl apply --context k3s-test -f -
./docs/kargo/controller_kubeconfig.sh prod https://k3s-mgmt.sikademo.com:6443 | kubectl apply --context k3s-prod -f -
```
