# Step 1 - Prepare Scenario Environment

## Create Namespace

```bash
kubectl create namespace payments
```

## Create Redis Deployment

```bash
kubectl -n payments create deployment redis --image=redis:7
```

## Label Redis Pods

```bash
kubectl -n payments label deployment redis app=redis --overwrite
```

## Expose Redis Service

```bash
kubectl -n payments expose deployment redis --name=redis-svc --port=6379 --target-port=6379
```

## Create Payments Deployment

```bash
kubectl -n payments create deployment payments-app --image=busybox -- sleep 3600
```

## Label Payments Pods

```bash
kubectl -n payments label deployment payments-app app=payments --overwrite
```

## Apply Default Deny Egress Policy

```bash
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
  namespace: payments
spec:
  podSelector: {}
  policyTypes:
  - Egress
EOF
```
