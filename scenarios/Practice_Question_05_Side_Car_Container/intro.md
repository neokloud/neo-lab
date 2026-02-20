** CKA Scenario: Add Sidecar Container to Existing Deployment**

- Update the existing deployment big-corp-app-deployment, adding a co located container named sidecar using the busybox:stable image to the existing pod. 
- The new co located container has to run the following command: /bin/sh -c "tail -f /var/log/big-corp.log" use a volume mounted at /var/log to make the log file big-corp.log available to co-located container



