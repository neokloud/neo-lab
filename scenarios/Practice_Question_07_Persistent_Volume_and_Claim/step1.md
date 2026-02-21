# Step 1 - Prepare Exam Environment

## Create Namespace

```
kubectl create namespace neodb
```

---

## Move to Home Directory

```
cd ~
```

---

## Create NeoDB Deployment File

```
cat <<EOF > neodb-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neodb
  namespace: neodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: local-neodb
  template:
    metadata:
      labels:
        app: local-neodb
    spec:
      containers:
      - name: neodb
        image: mysql:8.0
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "rootpassword"
        ports:
        - containerPort: 3306
        volumeMounts:
        - mountPath: /var/lib/mysql
          name: neodb-storage
      volumes:
      - name: neodb-storage
        persistentVolumeClaim:
          claimName: ""
EOF
```

---

## Create Retained PersistentVolume

```
cat <<EOF > pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: neodb-pv
spec:
  capacity:
    storage: 250Mi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: "/mnt/data/neodb"
EOF
```

---

## Apply PersistentVolume

```
kubectl apply -f pv.yaml
```
