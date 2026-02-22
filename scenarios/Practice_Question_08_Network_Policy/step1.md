# Step 1: Prepare Namespaces and Deployments

## Create frontend Namespace

```id="qk19fr"
kubectl create namespace frontend
```

---

## Create backend Namespace

```id="n5cc8s"
kubectl create namespace backend
```

---

## Create Frontend Deployment

```id="9p5n5k"
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-deploy
  namespace: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend
        image: busybox
        command: ["sh","-c","sleep 3600"]
EOF
```

---

## Create Backend Deployment (Listening on TCP 80)

```id="q1s7yx"
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend-deploy
  namespace: backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: backend
        image: nginx
        ports:
        - containerPort: 80
EOF
```
