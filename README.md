# ☸️ KUBE 🅰️NSIBLE

This repository is meant to install a kubernetes cluster on your local machine thanks to **Vagrant** and **Ansible**.<br>
There are two scripts located in this repository, **bootstrap.sh** and **purge.sh**.<br>
**Bootstrap** script require VAGRANT and ANSIBLE. It will provision vms and apply all the playbooks in the right order to bootstrap your cluster.<br>
**Purge** script will remove vms and clear the ssh known hosts entry related to vms.<br>

# 🅰️NSIBLE


Edit inventory file and change the path to your private key :
```
ansible_ssh_private_key_file: /home/adriamanu/.ssh/id_rsa
```
## PLAYBOOKS

### Update and upgrade apt packages
```bash
ansible-playbook ansible/misc/update-packages.yaml -i inventory.yaml
```

### Disable swap
```bash
ansible-playbook ansible/misc/disable-swap.yaml -i ../inventory.yaml
```

### Install docker
```bash
ansible-playbook ansible/docker/install-docker.yaml -i ../inventory.yaml
```

### Download K8S binaries
```bash
ansible-playbook ansible/kubernetes/download-kubernetes-binaries.yaml -i ../inventory.yaml
```

### Init master with Kubeadm
Master node is initialized with Kubeadm thanks to a config file that check here */ansible/config/kubeadm-ini-config.yaml*
```bash
ansible-playbook ansible/kubernetes/kubeadm-init-cluster.yaml -i inventory.yaml 
```

### Apply all playbooks
```bash
ansible-playbook ansible/misc/update-packages.yaml -i inventory.yaml \
&& ansible-playbook ansible/docker/install-docker.yaml -i inventory.yaml \
&& ansible-playbook ansible/misc/disable-swap.yaml -i inventory.yaml \
&& ansible-playbook ansible/kubernetes/download-kubernetes-binaries.yaml -i inventory.yaml \
&& ansible-playbook ansible/kubernetes/kubeadm-init-cluster.yaml -i inventory.yaml
```

### Connect to machines
```
ssh vagrant@192.168.1.60 -i .vagrant/machines/master/virtualbox/private_key
ssh vagrant@192.168.1.61 -i .vagrant/machines/node1/virtualbox/private_key
ssh vagrant@192.168.1.62 -i .vagrant/machines/node2/virtualbox/private_key
```

# VAGRANT
Once your machines have been provisioned and installed you can simply run:
```bash
vagrant up # to start your vms
vagrant halt # to delete your vms
```

# KUBECTL ☸️
### Apply kubectl commands
```bash
export KUBECONFIG=~/.kube/kube-ansible-config
```
```bash
kubectl get nodes
```