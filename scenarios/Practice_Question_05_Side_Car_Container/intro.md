# CKA Scenario: Add Sidecar Container to Existing Deployment

## Context

You are working in a Kubernetes cluster where an existing Deployment named `big-corp-app-deployment` is already running.

Your task is to update this Deployment by adding a **co-located container (sidecar pattern)** inside the same Pod.

---

## Objective

Modify the existing Deployment `big-corp-app-deployment` and:

- Add a new container named `sidecar`
- Use the image: `busybox:stable`
- Configure the container to run the following command: /bin/sh -c "tail -f /var/log/big-corp.log"

- Ensure the sidecar container can access the log file `big-corp.log`

---



