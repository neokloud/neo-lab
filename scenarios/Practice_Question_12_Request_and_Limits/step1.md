# Scenario Creation

## Step 1: Create Deployment File

Open a new file:

vi wordpress.yaml

Add the following content:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: wordpress
spec:
  replicas: 3
  selector:
    matchLabels:
      app: wordpress
  template:
    metadata:
      labels:
        app: wordpress
    spec:
      containers:
      - name: wordpress
        image: wordpress:latest
        ports:
        - containerPort: 80
      initContainers:
      - name: init-myservice
        image: busybox
        command: ['sh', '-c', 'echo Initializing...']

## Step 2: Apply Deployment

k apply -f wordpress.yaml
