# Scenario Creation – NGINX TLS Configuration

## Step 1: Create Namespace

kubectl create namespace nginx-static

---

## Step 2: Generate Self-Signed TLS Certificate
```
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout tls.key \
  -out tls.crt \
  -subj "/CN=web.k8s.local/O=web.k8s.local"
```
---

## Step 3: Create TLS Secret
```
kubectl -n nginx-static create secret tls nginx-tls \
  --cert=tls.crt \
  --key=tls.key
```

```
kubectl -n nginx-static describe secret nginx-tls
```
---

## Step 4: Create ConfigMap
```
vi nginx-config.yaml
```
Add the following:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
  namespace: nginx-static
data:
  nginx.conf: |
    events {}
    http {
      server {
        listen 443 ssl;
        ssl_protocols TLSv1.2 TLSv1.3; # initial state allowing TLS 1.2 and 1.3
        ssl_certificate /etc/nginx/ssl/tls.crt;
        ssl_certificate_key /etc/nginx/ssl/tls.key;

        location / {
          return 200 "Hello from NGINX with TLS!\n";
        }
      }
    }

kubectl apply -f nginx-config.yaml
```
---

## Step 5: Create Deployment
```
vi nginx-static-depl.yaml
```
Add the following:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-static
  namespace: nginx-static
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-static
  template:
    metadata:
      labels:
        app: nginx-static
    spec:
      volumes:
      - name: config
        configMap:
          name: nginx-config
      - name: nginx-tls
        secret:
          secretName: nginx-tls
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
```
```
kubectl apply -f nginx-static-depl.yaml
```
---

## Step 6: Expose Deployment
```
kubectl expose deployment -n nginx-static nginx-static \
  --port=443 \
  --target-port=443 \
  --name=nginx-node \
  --type=NodePort
```
```
kubectl get svc -n nginx-static
```
---

## Step 7: Update /etc/hosts Entry
```
sudo vi /etc/hosts
```
Add:
```
<ClusterIP> web.k8s.local
```
---

## Step 8: Test Current TLS Behavior
```
curl --tls-max 1.2 https://web.k8s.local -k
curl --tlsv1.3 https://web.k8s.local -k
curl --tls-max 1.1 https://web.k8s.local -k -v
```
At this stage:
TLS 1.2 and TLS 1.3 should work.
