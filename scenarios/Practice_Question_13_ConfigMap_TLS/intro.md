# Kubernetes NGINX TLS Configuration – Restrict to TLSv1.3

An NGINX Deployment named nginx-static is running in the nginx-static namespace.

The application is configured using a ConfigMap named nginx-config.  
Currently, the NGINX configuration allows both TLSv1.2 and TLSv1.3 connections.

Your task is to update the ConfigMap so that:

- Only TLSv1.3 connections are allowed.
- TLSv1.2 and lower versions must be blocked.
- Restart, recreate, or scale resources if necessary for changes to take effect.
- Validate the configuration using curl commands.

After modification:

The following command must fail:

curl --tls-max 1.2 https://web.k8s.local -k

The following command must work:

curl --tlsv1.3 https://web.k8s.local -k

Only TLS 1.3 connections should succeed after the update.
