.PHONY: help
help:
	@echo use:
	@echo - make install-argocd-sikademo

.PHONY: install-argocd-sikademo
install-argocd-sikademo:
	(cd _argocd && helm dependency update)
	helm upgrade \
		--install \
		--create-namespace \
		--namespace argocd \
		argocd ./_argocd \
		--values ./_argocd/values-sikademo.yaml
