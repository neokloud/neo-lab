```
kubectl create namespace neokloud

```
```
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: front-end
  namespace: neokloud
spec:
  replicas: 2
  selector:
    matchLabels:
      app: front-end
  template:
    metadata:
      labels:
        app: front-end
    spec:
      containers:
      - name: nginx-container
        image: nginx:latest
        # Note: Intentionally no containerPort to begin with
        # We'll add it in the solution steps
EOF
```
