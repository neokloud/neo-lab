# Step 1 – Scenario Creation (Copy-Paste Ready Commands)

## 1️⃣ Create Pod
```
kubectl run web-pod --image=nginx --port=80
```
---

## 2️⃣ Expose Pod as Service
```
kubectl expose pod web-pod --name=web-service --port=80 --target-port=80  
kubectl get svc web-service
```
---

## 3️⃣ Create TLS Secret
```
kubectl create secret tls tls-secret \
--cert=/etc/kubernetes/pki/apiserver.crt \
--key=/etc/kubernetes/pki/apiserver.key
```
kubectl get secret tls-secret

---
```
## 4️⃣ Create Ingress YAML
```
cat <<EOF > web-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web
spec:
  tls:
  - hosts:
    - gateway.web.k8s.local
    secretName: tls-secret
  rules:
  - host: gateway.web.k8s.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
EOF
```
```
kubectl apply -f web-ingress.yaml
```
---

## 5️⃣ Install Gateway API CRDs
```
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml
```
---

## 6️⃣ Create GatewayClass
```
cat <<EOF > gatewayclass.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: nginx
spec:
  controllerName: k8s.io/nginx-gateway-controller
EOF
```
```
kubectl apply -f gatewayclass.yaml
```
---

## 7️⃣ Create Gateway
```
cat <<EOF > web-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: web-gateway
spec:
  gatewayClassName: nginx
  listeners:
  - name: https
    protocol: HTTPS
    port: 443
EOF
```
```
kubectl apply -f web-gateway.yaml
```
