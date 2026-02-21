# Step 2 - Prepare Namespace and Deployment

## Create Namespace and Deployment

```id="cmd01"
kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: auto-scale
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neokloud-server
  namespace: auto-scale
spec:
  replicas: 1
  selector:
    matchLabels:
      app: neokloud-server
  template:
    metadata:
      labels:
        app: neokloud-server
    spec:
      containers:
      - name: neokloud-server
        image: httpd:latest
        resources:
          requests:
            cpu: 100m
          limits:
            cpu: 200m
EOF
```

