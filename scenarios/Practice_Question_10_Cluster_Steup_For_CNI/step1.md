# Download cri-dockerd Package

```
wget $(curl -s https://api.github.com/repos/Mirantis/cri-dockerd/releases/latest | grep browser_download_url | grep "ubuntu-jammy_amd64.deb" | cut -d '"' -f 4)
```
