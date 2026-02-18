<div style="font-size:11px;">

<b> cert-manager Issuer Field Extraction</b><br><br>

🧪 <b>Task:</b><br><br>

Verify cert-manager is running in the cluster.<br><br>

List all cert-manager CRDs and save to:<br>
<code>~/issuer-resources.yaml</code><br><br>

Extract <code>.spec.acme</code> field of Issuer custom resource and save to:<br>
<code>~/acme-doc.yaml</code><br><br>

Extract <code>.spec.subject</code> field of Certificate custom resource and save to:<br>
<code>~/subject-doc.yaml</code><br><br>

<hr>

<b>cert-manager Issuer Field Extraction</b><br><br>

✅ <b>Install cert-manager:</b><br><br>

<code>
kubectl create namespace cert-manager<br>
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.2/cert-manager.yaml
</code><br><br>

<hr>

✅ <b>Solve the Question:</b><br><br>

<code>
# List CRDs<br>
kubectl get crds | grep cert-manager > ~/issuer-resources.yaml<br><br>

# Extract .spec.acme field<br>
kubectl explain issuers.cert-manager.io.spec.acme > ~/acme-doc.yaml<br><br>

# Extract .spec.subject field<br>
kubectl explain certificates.cert-manager.io.spec.subject > ~/subject-doc.yaml
</code>

</div>
