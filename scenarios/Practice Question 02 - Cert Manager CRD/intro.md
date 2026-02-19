# Mock 2: Placeholder Introduction
You are preparing a Linux system for Kubernetes setup using cri-dockerd.

Perform the following tasks:

Install the package cri-dockerd_0.3.9.3-0.ubuntu-focal_amd64.deb (assume it’s available in the current directory).

Enable and start the cri-dockerd systemd service.

Configure and persist these system parameters:

net.bridge.bridge-nf-call-iptables = 1

net.ipv6.conf.all.forwarding = 1

net.ipv4.ip_forward = 1
