# Restore NeoDB Deployment

A NeoDB Deployment in the `neodb` namespace has been deleted by mistake. Your task is to restore the Deployment while ensuring data persistence.
---

# Tasks
#  Create a PersistentVolumeClaim (PVC)
* Name: `neodb`
* Namespace: `neodb`
* Storage Request: `250Mi`
* Use the existing retained PersistentVolume (only one PV exists).
---
# Modify the NeoDB Deployment

The Deployment file is located at:

~/neodb-deployment.yaml

Update the Deployment to use the PVC neodb created in the previous step.

Apply the updated Deployment to the cluster.
---
# Validation
Ensure the following:
* NeoDB Pod is running
* PVC is bound to the retained PersistentVolume
