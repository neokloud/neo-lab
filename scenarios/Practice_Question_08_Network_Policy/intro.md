# NetworkPolicy: Restrict Frontend to Backend Communication

You are working on a Kubernetes cluster that contains two namespaces:

* `frontend`
* `backend`

Pods running in the `frontend` namespace use the label `app: frontend`.

Pods running in the `backend` namespace use the label `app: backend` and expose an application listening on `TCP 80`.

## Requirement

Configure a Kubernetes NetworkPolicy so that:

* Only Pods labeled `app: frontend`
* From the `frontend` namespace
* Are allowed to access Pods labeled `app: backend`
* In the `backend` namespace
* Using `TCP 80`

All other incoming traffic to backend Pods must remain blocked.

Apply the most suitable NetworkPolicy to satisfy this requirement.
