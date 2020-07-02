#!/bin/bash
OUTPUT_FILE=/vagrant/join.sh
rm -rf $OUTPUT_FILE
# Start cluster
sudo kubeadm init --apiserver-advertise-address=192.168.56.2 --control-plane-endpoint=192.168.56.2 --pod-network-cidr=10.244.0.0/16 
sudo kubeadm token create --print-join-command > ${OUTPUT_FILE}
chmod +x $OUTPUT_FILE

# Configure kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

cat >> ~/.bashrc <<-EOF
alias k=kubectl
source <(kubectl completion bash)
complete -F __start_kubectl k
EOF

# Configure flannel
curl -o kube-flannel.yml https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#sed  '189s|args:|- --kube-subnet-mg\n        - --iface=enp0s8|' kube-flannel.yml | grep -n iface -C 1
sed -i.bak '189s|args:.*|args:\n        - --iface=enp0s8|' kube-flannel.yml 
kubectl create -f kube-flannel.yml
