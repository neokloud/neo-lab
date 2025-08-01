#!/bin/bash

# Create namespace
kubectl create namespace ng-tic

# Generate TLS certs
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout tls.key \
  -out tls.crt \
  -subj "/CN=web.k8s.local/O=web.k8s.local"

# Create TLS secret
kubectl -n ng-tic create secret tls ng-tls \
  --cert=tls.crt \
  --key=tls.key

# Create ConfigMap allowing TLSv1.2 and TLSv1.3
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
  namespace: ng-tic
data:
  nginx.conf: |
    events {}
    http {
      server {
        listen 443 ssl;
        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_certificate /etc/nginx/ssl/tls.crt;
        ssl_certificate_key /etc/nginx/ssl/tls.key;

        location / {
          return 200 "Hello from NGINX with TLS!\n";
        }
      }
    }
EOF

# Create Deployment
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ng-tic
  namespace: ng-tic
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ng-tic
  template:
    metadata:
      labels:
        app: ng-tic
    spec:
      volumes:
      - name: config
        configMap:
          name: nginx-config
      - name: nginx-tls
        secret:
          secretName: ng-tls
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 443
        volumeMounts:
        - name: config
          mountPath: /etc/nginx/nginx.conf
          subPath: nginx.conf
        - name: nginx-tls
          mountPath: /etc/nginx/ssl
EOF

# Create ClusterIP Service
kubectl expose deployment -n ng-tic ng-tic \
  --port=443 --target-port=443 \
  --name=ng-node --type=ClusterIP

echo "✅ Setup complete. Add ClusterIP to /etc/hosts for web.k8s.local"
