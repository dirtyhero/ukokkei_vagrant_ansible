Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.define "core", primary: true do |machine|
    machine.vm.network "private_network", ip: "172.17.177.21"
    machine.vm.hostname = "core"
    machine.vm.network "forwarded_port", guest: 3000, host:3000
    machine.vm.provider "virtualbox" do |vb|
     # Customize the amount of memory on the VM:
     vb.memory = "2048"
     # Set the time to HOST
     vb.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 0]
    end
  end

  config.vm.define "frontend", autostart: false do |machine|
    machine.vm.network "private_network", ip: "172.17.177.22"
    machine.vm.hostname = "frontend"
  end

  config.vm.define "backend", autostart: false do |machine|
    machine.vm.network "private_network", ip: "172.17.177.23"
    machine.vm.hostname = "backend"
  end

  config.vm.define "api", autostart: false do |machine|
    machine.vm.network "private_network", ip: "172.17.177.24"
    machine.vm.hostname = "api"
  end

  config.vm.define 'controller' do |machine|
    machine.vm.network "private_network", ip: "172.17.177.11"
    machine.vm.hostname = "controller"
    machine.vm.provision :shell, path: "install-ansible.sh"
    machine.vm.provision :ansible_local do |ansible|
      ansible.playbook       = "provisioning/playbook.yml"
      ansible.verbose        = true
      ansible.install        = true
      ansible.limit          = "all" # or only "nodes" group, etc.
      ansible.inventory_path = "inventory"
    end
  end
end