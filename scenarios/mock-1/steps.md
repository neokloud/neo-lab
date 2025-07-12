# Mock 1: Argo CD Installation using Helm

1️⃣ Add Argo Helm Repo:
```
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

2️⃣ Render Manifest Without CRDs:
```
helm template argo-cd argo/argo-cd   --version 8.0.17   --namespace argocd   --set crds.install=false > argo-template.yaml
```

3️⃣ Apply to Cluster:
```
kubectl create namespace argocd
kubectl apply -f argo-template.yaml
```