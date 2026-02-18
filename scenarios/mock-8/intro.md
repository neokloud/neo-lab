<div style="font-size:11px;">

<h1>StorageClass Creation and Configuration</h1>

<h2>Scenario Overview</h2>

<p>
In this lab, you will configure a Kubernetes StorageClass following CKA-style requirements.
</p>

<p>
Your goal is to create and properly configure a StorageClass without modifying any existing Deployments or PersistentVolumeClaims.
</p>

<p>
This scenario simulates a real exam-style environment where existing workloads are already running in the cluster.
</p>

<hr>

<h2>Objectives</h2>

<ul>
<li>Create a new StorageClass named <b>local-path</b></li>
<li>Set the provisioner to <b>rancher.io/local-path</b></li>
<li>Configure <b>volumeBindingMode</b> to <b>WaitForFirstConsumer</b></li>
<li>Configure <b>local-path</b> as the default StorageClass</li>
<li>Ensure no existing Deployments or PersistentVolumeClaims are modified</li>
</ul>

<hr>

<h2>Important Notes</h2>

<ul>
<li>Do NOT delete or recreate existing resources unless absolutely necessary.</li>
<li>Verify your changes carefully.</li>
<li>Ensure only one StorageClass is marked as default.</li>
</ul>

<hr>

<h2>Expected Outcome</h2>

<p>
After completing this lab:
</p>

<ul>
<li><b>local-path</b> should be the default StorageClass</li>
<li><b>volumeBindingMode</b> must be set to <b>WaitForFirstConsumer</b></li>
<li>Existing resources should remain untouched</li>
</ul>

<p>
Use <code>kubectl get sc</code> and <code>kubectl describe sc</code> to verify your configuration.
</p>

<p><b>Good luck 🚀</b></p>

</div>
