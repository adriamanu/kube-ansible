# enp5s0 netmask is 255.255.255.0 -> we can only adress our machines on 
Vagrant.configure("2") do |config|
  config.vm.provision "shell" do |s|
    ssh_public_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
    s.inline = <<-SHELL
      echo #{ssh_public_key} >> /home/vagrant/.ssh/authorized_keys
      echo #{ssh_public_key} >> /root/.ssh/authorized_key
    SHELL
  end
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end

  config.vm.define  "master" do |master|
    master.vm.box = "ubuntu/bionic64"
    master.vm.hostname = "master"
    master.vm.network "public_network", bridge: "enp5s0", ip: "192.168.1.60"
  end

  config.vm.define  "node1" do |node1|
    node1.vm.box = "ubuntu/bionic64"
    node1.vm.hostname = "node1"
    node1.vm.network "public_network", bridge: "enp5s0", ip: "192.168.1.61"
  end

  config.vm.define  "node2" do |node2|
    node2.vm.box = "ubuntu/bionic64"
    node2.vm.hostname = "node2"
    node2.vm.network "public_network", bridge: "enp5s0", ip: "192.168.1.62"
  end
end
