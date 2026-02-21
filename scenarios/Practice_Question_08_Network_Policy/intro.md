# NetworkPolicy Egress Control

You are working in a Kubernetes cluster.

The namespace `payments` already contains a **default-deny egress NetworkPolicy**, meaning no outbound traffic is allowed unless explicitly permitted.

Pods running payment workloads are labeled:

`app: payments`

A Redis database is running inside the same namespace and is exposed through the Service:

`redis-svc.payments.svc.cluster.local`

## Task

Configure networking so that pods labeled `app=payments` can:

* connect **only** to Redis pods
* communicate **only within** the `payments` namespace
* use **TCP port `6379`**

No other egress traffic must be allowed.
