# Step 1: Scenario Creation

Run the following command to create the base deployment:

```bash
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: big-corp-app-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: big-corp-app
  template:
    metadata:
      labels:
        app: big-corp-app
    spec:
      containers:
        - name: monitor
          image: lfcert/monitor:latest
          env:
            - name: LOG_FILENAME
              value: /var/log/big-corp.log
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
