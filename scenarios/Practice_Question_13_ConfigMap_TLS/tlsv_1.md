# Enforcing TLSv1.3 Only for nginx-static Deployment

## Namespace
`nginx-static`

## ConfigMap Name
`nginx-config`

---

# Scenario
The NGINX application currently allows both **TLSv1.2** and **TLSv1.3** connections.  
The objective is to:

- Allow **only TLSv1.3**
- Block **TLSv1.2 and lower versions**
- Restart resources if required
- Validate using curl

---

# ✅ Procedure (When ConfigMap is Editable)

## Step 1: Edit the ConfigMap

```bash
kubectl edit configmap nginx-config -n nginx-static
```

Locate the SSL configuration section.

### Existing Configuration:
```nginx
ssl_protocols TLSv1.2 TLSv1.3;
```

### Modify To:
```nginx
ssl_protocols TLSv1.3;
```

Ensure TLSv1.2 is completely removed.

Save and exit.

---

## Step 2: Restart Deployment

ConfigMap updates do NOT automatically reload inside running pods.

```bash
kubectl rollout restart deployment nginx-static -n nginx-static
```

Verify pod restart:

```bash
kubectl get pods -n nginx-static
```

Wait until pods are in `Running` state.

---

## Step 3: Verify Configuration Inside Pod (Recommended)

```bash
kubectl exec -it <nginx-pod-name> -n nginx-static -- nginx -T | grep ssl_protocols
```

Expected output:

```nginx
ssl_protocols TLSv1.3;
```

---

# ✅ Validation Tests

## 🔴 TLS 1.2 Must Fail

```bash
curl --tls-max 1.2 https://web.k8s.local -k
```

Expected:
- SSL handshake failure
- Connection error

Example error:
```
curl: (35) error:0A000102:SSL routines::unsupported protocol
```

---

## 🟢 TLS 1.3 Must Succeed

```bash
curl --tlsv1.3 https://web.k8s.local -k
```

Expected:
- HTTP 200 response
- Page content returned

---

# ✅ Final Verification Checklist

| Test | Expected Result |
|------|-----------------|
| TLS 1.2 | ❌ FAIL |
| TLS 1.3 | ✅ SUCCESS |
| ssl_protocols | TLSv1.3 only |

---

# 🔎 Troubleshooting

If TLS 1.2 still works, verify:

- Another ConfigMap is not mounted
- Default NGINX config is not overriding
- Pods actually restarted
- TLS is not terminated at Ingress level

Additional verification:

```bash
openssl s_client -connect web.k8s.local:443 -tls1_2
```

It must fail.

---

# 🚨 If ConfigMap is Immutable

If you receive:

```
Error from server (Forbidden): configmaps "nginx-config" is immutable
```

You cannot edit or patch the ConfigMap.

---

# ✅ Solution: Recreate the ConfigMap

## Step 1: Export Existing ConfigMap

```bash
kubectl get configmap nginx-config -n nginx-static -o yaml > nginx-config.yaml
```

---

## Step 2: Modify the File

Change:

```nginx
ssl_protocols TLSv1.2 TLSv1.3;
```

To:

```nginx
ssl_protocols TLSv1.3;
```

Ensure:

- Remove `immutable: true`
- Or set `immutable: false`

---

## Step 3: Delete Old ConfigMap

⚠ Ensure deployment can tolerate brief downtime.

```bash
kubectl delete configmap nginx-config -n nginx-static
```

---

## Step 4: Recreate Updated ConfigMap

```bash
kubectl apply -f nginx-config.yaml
```

---

## Step 5: Restart Deployment

```bash
kubectl rollout restart deployment nginx-static -n nginx-static
```

Verify:

```bash
kubectl get pods -n nginx-static
```

---

## Step 6: Validate Again

TLS 1.2 must fail:

```bash
curl --tls-max 1.2 https://web.k8s.local -k
```

TLS 1.3 must work:

```bash
curl --tlsv1.3 https://web.k8s.local -k
```

---

# 🔄 Zero-Downtime Alternative (Recommended for Production)

1. Create new ConfigMap:

```bash
kubectl create configmap nginx-config-v2 --from-file=nginx.conf -n nginx-static
```

2. Update Deployment to reference `nginx-config-v2`
3. Perform rollout restart

This avoids deletion gap.

---

# 📌 Key Kubernetes Concept

When `immutable: true` is set:

- Editing is impossible
- Patching is not allowed
- Resource must be recreated
- Used for performance optimization and configuration safety in production clusters

---

# Conclusion

After successful implementation:

✔ Only TLSv1.3 connections succeed  
✖ TLSv1.2 and lower are blocked  
✔ Deployment is restarted properly  
✔ Configuration validated using curl and openssl

---

End of Document

