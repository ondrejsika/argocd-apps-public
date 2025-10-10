default:
	@echo "Please specify a target, e.g., 'make setup-sikademo'"

setup_sikademo:
	@slu check kubernetes_context -p do-fra1-sikademo
	slu scripts kubernetes install-argocd
	kubectl apply -f ./clusters/sikademo
