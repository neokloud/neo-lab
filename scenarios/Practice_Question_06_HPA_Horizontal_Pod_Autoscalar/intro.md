# Horizontal Pod Autoscaler Task

Create a Horizontal Pod Autoscaler (HPA) named `neokloud-server` in the `auto-scale` namespace.

The HPA must target the existing Deployment `neokloud-server` running in the same namespace.

Configure the autoscaler with the following requirements:

* Target average CPU utilization: `50% per pod`
* Minimum replicas: `1`
* Maximum replicas: `4`
* Downscale stabilization window: `30 seconds`
