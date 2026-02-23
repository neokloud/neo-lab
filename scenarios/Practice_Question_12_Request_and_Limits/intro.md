# Kubernetes Resource Optimization – WordPress Deployment

You are managing a WordPress application running in a Kubernetes cluster. The current Deployment is configured with 3 replicas, but some Pods are failing to run due to insufficient resource allocation and node constraints.

Your task is to stabilize the application by properly configuring CPU and memory requests and limits.

## Objectives

1. Scale down the `wordpress` Deployment to 0 replicas.
2. Modify the Deployment configuration to:
   - Divide node resources evenly across all 3 Pods.
   - Assign fair and equal CPU and memory requests to each Pod.
   - Add reasonable overhead to prevent node instability.
   - Ensure both init containers and main containers use exactly the same resource requests and limits.
3. Scale the Deployment back to 3 replicas after applying the changes.

Ensure the application runs stably with properly balanced resource allocation.
