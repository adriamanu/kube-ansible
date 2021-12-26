# What's going on with the kubeadm-init-cluster playbook

## Pick up the kubectl config file
On the **master** vm run this command with the right privileges :
```bash
cp -i /etc/kubernetes/admin.conf /home/vagrant/config && chmod 0644 config
```
Then we will fetch this file from your local machine (the host) in order to perform kubectl commands from here.<br>
```bash
scp -i .vagrant/machines/master/virtualbox/private_key vagrant@192.168.1.60:/home/vagrant/config ~/.kube/kube-ansible-config
```
Then pick up the right config file and then run a kubectl command to check that this works as expected:
```bash
export KUBECONFIG=~/.kube/kube-ansible-config
kubectl get nodes
```

## Install network add-on - Flannel
https://github.com/flannel-io/flannel <br>
We need to install a network add-on so that our pod can communicates with each others.<br>

We set iptables proxy
```bash
sysctl net.bridge.bridge-nf-call-iptables=1
```

Apply the yaml manifest
```bash
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

## Generate join command
Once master has been installed successfully we will need to join the cluster with the nodes.
To do so, this command is run on the **master**.
```bash
kubeadm token create --print-join-command
```
It will output something like this :
```bash
kubeadm join 192.168.1.60:6443 --token ***************** --discovery-token-ca-cert-hash sha256:***************************************
```
The this join command is executed on **node1** and **node2** hosts.