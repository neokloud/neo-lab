# Step 1 - Install Metrics Server

## Install Metrics Server

```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

## Enable insecure TLS communication with Kubelets

```
kubectl -n kube-system patch deployment metrics-server \
--type='json' \
-p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
```

## Wait for Metrics Server rollout

```
kubectl rollout status deployment metrics-server -n kube-system
```

## Verify Metrics Server

```
kubectl top nodes
```

```
kubectl top pods -A
```
