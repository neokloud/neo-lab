# Prepare Linux System for Kubernetes

Docker is already installed on this system.
Your task is to prepare the Linux host so it becomes ready for Kubernetes initialization using `kubeadm`.

Install **cri-dockerd** using the provided Debian package located at:

`~/cri-dockerd_0.3.9.3-0.ubuntu-jammy_amd64.deb`

After installation, ensure the `cri-docker` service is properly enabled and running so Kubernetes can communicate with Docker through the Container Runtime Interface.

Next, configure the required kernel networking parameters needed by Kubernetes networking components.

Set the following system parameters:

`net.bridge.bridge-nf-call-iptables = 1`
`net.ipv6.conf.all.forwarding = 1`
`net.ipv4.ip_forward = 1`
`net.netfilter.nf_conntrack_max = 131072`

The system must be correctly configured so container networking, packet forwarding, and connection tracking work as expected before proceeding with Kubernetes cluster setup.
