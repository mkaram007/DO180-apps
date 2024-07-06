```
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >>~/.bashrc

sudo cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep -i cluster-cidr





wget https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
vim kube-flannel.yml

net-conf.json: |
    {
      "Network": "10.100.0.0/24",
      "Backend": {
        "Type": "vxlan"
      }
    }



#####JOIN FIIIIIRRRRRRSSSSSSSTTTTTT

kubectl patch node master -p '{"spec":{"podCIDR":"10.100.0.0/24"}}'
kubectl patch node worker01 -p '{"spec":{"podCIDR":"10.100.1.0/24"}}'
kubectl patch node worker02 -p '{"spec":{"podCIDR":"10.100.2.0/24"}}'


kubectl label nodes worker01 node-role.kubernetes.io/worker=worker
kubectl label nodes worker02 node-role.kubernetes.io/worker=worker
```




## For registries
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=<path/to/.docker/config.json> \
    --type=kubernetes.io/dockerconfigjson

containers:
- name: asdasdasd
  image: asdasdasd
imagePullSecrets:
- name: regcred
