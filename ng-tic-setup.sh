#!/bin/bash

set -e

echo "🔧 Creating namespace..."
kubectl create namespace ng-tic || echo "Namespace ng-tic already exists."

echo "🔐 Generating TLS certs..."
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout tls.key \
  -out tls.crt \
  -subj "/CN=web.k8s.local/O=web.k8s.local"

echo "🔐 Creating TLS secret..."
kubectl -n ng-tic create secret tls ng-tls \
  --cert=tls.crt --key=tls.key || echo "TLS secret ng-tls already exists."

echo "🧾 Creating ConfigMap with TLSv1.2 and TLSv1.3 support..."
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
          return 200 "Hello from NGINX with TLS!\\n";
        }
      }
    }
EOF

echo "📦 Creating Deployment..."
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

echo "🌐 Exposing service via ClusterIP..."
kubectl expose deployment -n ng-tic ng-tic \
  --port=443 --target-port=443 \
  --name=ng-node --type=ClusterIP

echo "🔎 Getting ClusterIP..."
CLUSTER_IP=$(kubectl get svc -n ng-tic ng-node -o jsonpath='{.spec.clusterIP}')
echo "ClusterIP: $CLUSTER_IP"

# Check if already exists in /etc/hosts
grep -q "web.k8s.local" /etc/hosts || echo "$CLUSTER_IP web.k8s.local" | sudo tee -a /etc/hosts

echo "✅ /etc/hosts updated."

echo "⏳ Waiting for pod to become ready..."
kubectl wait --namespace ng-tic --for=condition=ready pod -l app=ng-tic --timeout=60s

echo "🧪 Testing TLS connections..."
echo -e "\n-- TLS 1.3 test (Should work) --"
curl --tlsv1.3 https://web.k8s.local -k

echo -e "\n-- TLS 1.2 test (Should work initially) --"
curl --tls-max 1.2 https://web.k8s.local -k

echo -e "\n-- TLS 1.1 test (Should fail) --"
curl --tls-max 1.1 https://web.k8s.local -k -v || echo "✅ Expected failure for TLS 1.1"
