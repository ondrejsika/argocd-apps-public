default:
	@echo "Please specify a target, e.g., 'make setup-sikademo'"

setup_sikademo:
	@slu check kubernetes_context -p do-fra1-sikademo
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/sikademo

setup_example_lab0:
	@slu check kubernetes_context -p k3d-default
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/example_lab0

setup_example_rke2:
	@slu check kubernetes_context -p rke2
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/example_rke2
