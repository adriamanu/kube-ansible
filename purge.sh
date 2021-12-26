echo "Remove keys belonging to master/node1/node2 hosts"
for host in 192.168.1.60 192.168.1.61 192.168.1.62
do
    ssh-keygen -R $host
done

echo "Remove provisioned machines with Vagrant"
vagrant destroy -f
