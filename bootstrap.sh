#!/bin/bash

## FUNCTIONS
check_command() {
    if ! command -v $1 &> /dev/null
    then
        echo "$1 is not installed on your machine"
        exit
    fi
}


## SCRIPT
# Check if binary are present on the machine before trying to apply current script
check_command "ansible"
check_command "vagrant"

echo "Provisioning vms ⏳"
vagrant up
echo "Provisioning done ⌛"

echo "Add vms adresses to list of know hosts"
for host in 192.168.1.60 192.168.1.61 192.168.1.62
do
    ssh-keyscan $host >> ~/.ssh/known_hosts
done

echo "Update packages 📦"
ansible-playbook ansible/misc/update-packages.yaml -i inventory.yaml
echo "Install docker 🐋"
ansible-playbook ansible/docker/install-docker.yaml -i inventory.yaml
echo "Disable swapping"
ansible-playbook ansible/misc/disable-swap.yaml -i inventory.yaml
echo "Download kubernetes binaries - kubeadm / kubelet / kubectl 📦"
ansible-playbook ansible/kubernetes/download-kubernetes-binaries.yaml -i inventory.yaml
echo "Initialize kubernetes cluster with Kubeadm ☸️"
ansible-playbook ansible/kubernetes/kubeadm-init-cluster.yaml -i inventory.yaml

echo "Installation complete, you are ready to sail ! ⛵"
echo
echo "To check your kubernetes installation:"
echo "export KUBECONFIG=~/.kube/kube-ansible-config"
echo "kubectl get nodes"
echo