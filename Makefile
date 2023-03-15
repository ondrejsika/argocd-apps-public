sikademo-setup:
	make install-argocd-sikademo
	make sikademo-apply-app-of-apps

install-argocd-sikademo:
	slu scripts kubernetes install-argocd --domain argocd.k8s.sikademo.com

sikademo-apply-app-of-apps:
	kubectl apply -f ./meta/sikademo.yml

argocd-proxy:
	kubectl port-forward -n argocd svc/argocd-server 8443:443

argocd-password:
	@slu argocd initial-password
