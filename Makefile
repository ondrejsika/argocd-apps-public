default:
	@echo "Please specify a target, e.g., 'make setup-sikademo'"

setup_panda:
	@slu check kubernetes_context -p panda
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/panda

setup_sikademo:
	@slu check kubernetes_context -p do-fra1-sikademo
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/sikademo

setup_example:
	@slu check kubernetes_context -p do-fra1-sikademo
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/example

setup_example_lab0:
	@slu check kubernetes_context -p k3d-default
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/example_lab0

setup_example_rke2:
	@slu check kubernetes_context -p rke2
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/example_rke2

setup_openshift:
	@slu check kubernetes_context -p default/api-training-germanywestcentral-aroapp-io
	kubectl apply -f ./apps/openshift/_system/argocd/manifests/01_ns.yaml
	kubectl apply -f ./apps/openshift/_system/argocd/manifests/02_operatorgroup.yaml
	kubectl apply -f ./apps/openshift/_system/argocd/manifests/03_subscription.yaml
	kubectl apply -f ./apps/openshift/_system/argocd/manifests/04_rbac.yaml
	kubectl wait --for condition=established --timeout=600s crd/argocds.argoproj.io
	kubectl apply -f ./apps/openshift/_system/argocd/manifests/05_argocd_config.yaml
	kubectl wait --for condition=established --timeout=600s crd/applications.argoproj.io
	kubectl apply -f ./clusters/openshift

setup_akc:
	@slu check kubernetes_context -p default/api-akc-germanywestcentral-aroapp-io
	kubectl apply -f ./apps/akc/_system/argocd/manifests/01_ns.yaml
	kubectl apply -f ./apps/akc/_system/argocd/manifests/02_operatorgroup.yaml
	kubectl apply -f ./apps/akc/_system/argocd/manifests/03_subscription.yaml
	kubectl apply -f ./apps/akc/_system/argocd/manifests/04_rbac.yaml
	kubectl wait --for condition=established --timeout=600s crd/applications.argoproj.io
	kubectl apply -f ./clusters/akc
