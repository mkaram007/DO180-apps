## Install 1 master & 1 worker
* Static password, connectivity
1. NOPASSWD
2. Install
    - `dnf install -y vim bash-completion wget tar`
* hostname
    - `hostnamectl hostname master`
* /etc/hosts
    - `localhost master`
* Firewall
    - `sudo firewall-cmd --add-port=30000-32767/tcp --permanent`
* SWAP

* INSTALL DOCKER
    - `https://docs.docker.com/engine/install/centos/`
    - Configure containerd
        - `containerd config default > /etc/containerd/config.toml`
        - `sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml`
        - `systemctl restart containerd`
* INSTALL K8s
    - `https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/`
    - `https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/`


* CONFIGURE KERNEL
```
cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

lsmod | grep br_netfilter
lsmod | grep overlay


cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system


sudo reboot
```



KUBEADM config
```
# kubeadm-config.yaml
#controlPlaneEndpoint: "192.168.202.200:6443"
kind: ClusterConfiguration
apiVersion: kubeadm.k8s.io/v1beta3
kubernetesVersion: v1.28.2
networking:
    podSubnet: "10.100.0.0/24"
---
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
cgroupDriver: systemd
podCIDR: "10.100.0.0/24"
```
    - Pull Images
        - `sudo usermod -aG docker karam`

        - `kubeadm config images list`
        - `kubeadm config images pull`


- `kubeadm init --config=kubeadm-config.yaml`


- `kubectl config set-context --current --namespace=.......`

* Install calico
- `curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml -O`
- `kubectl apply -f calico.yaml`


- `kubectl taint nodes master01 node.kubernetes.io/not-ready=:NoSchedule-`
