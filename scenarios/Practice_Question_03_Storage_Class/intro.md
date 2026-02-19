### StorageClass Configuration Task

Create a new StorageClass named **local-path-k8s** with the provisioner **rancher.io/local-path**.

Set the **volumeBindingMode** to **WaitForFirstConsumer**.

Configure the StorageClass **local-path-k8s** as the default StorageClass.

Do not modify any existing Deployments or PersistentVolumeClaims.
