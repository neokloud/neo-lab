# Step 1: Scenario Creation

Run the following command to create the base deployment:

```bash
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neokloud-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: neokloud
  template:
    metadata:
      labels:
        app: neokloud
    spec:
      containers:
        - name: monitor
          image: lfcert/monitor:latest
          env:
            - name: LOG_FILENAME
              value: /var/log/neokloud.log
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      terminationGracePeriodSeconds: 30
      tolerations:
        - effect: NoExecute
          key: node.kubernetes.io/not-ready
          operator: Exists
          tolerationSeconds: 300
        - effect: NoExecute
          key: node.kubernetes.io/unreachable
          operator: Exists
          tolerationSeconds: 300
EOF


```
