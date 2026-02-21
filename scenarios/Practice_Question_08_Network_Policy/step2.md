# Step 2 - Create NetworkPolicy Options

## Create Option A NetworkPolicy

```bash id="optA"
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-redis-egress
  namespace: payments
spec:
  podSelector:
    matchLabels:
      app: payments
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: redis
      namespaceSelector:
        matchLabels:
          kubernetes.io/metadata.name: payments
    ports:
    - protocol: TCP
      port: 6379
EOF
```

## Create Option B NetworkPolicy

```bash id="optB"
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-redis
  namespace: payments
spec:
  podSelector:
    matchLabels:
      app: payments
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 10.96.0.0/12
    ports:
    - protocol: TCP
      port: 6379
EOF
```

## Create Option C NetworkPolicy

```bash id="optC"
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: payments-egress
  namespace: payments
spec:
  podSelector:
    matchLabels:
      app: payments
  policyTypes:
  - Egress
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          kubernetes.io/metadata.name: payments
      podSelector:
        matchLabels:
          app: redis
    ports:
    - protocol: TCP
      port: 6379
EOF
```
