ukokkei_vagrant_ansible_local

# Description
set up VM to run ukokkei with Vagrant, Ansible

# Environment

- OS OS X EL Capitan 10.11.5
- Vagrant 1.8.1

**not tried, but this will used on linux machine**

# You Need...
- Git
- Vagrant
- VirtualBox

# Step
## step 0
Suppose you have local directory like below

 ```
ootsukakouhei-no-MacBook-Pro:ukokkei kohei$ pwd
/Users/kohei/development/github/ukokkei

ootsukakouhei-no-MacBook-Pro:ukokkei kohei$ ll
drwxr-xr-x 20 kohei staff 680  6  4 16:37 ukokkei_backend
drwxr-xr-x 26 kohei staff 884  6  4 13:31 ukokkei_core
drwxr-xr-x 20 kohei staff 680  6  4 12:47 ukokkei_dummy
drwxr-xr-x 20 kohei staff 680  5 23 18:00 ukokkei_frontend

 ``` 
 
## step 1 clone VagrantFile, and Ansible's stuff into anywhere

``` shell
cd ~/
git clone git@github.com:Kohei909Otsuka/ukokkei_vagrant_ansible.git
```

## step 2 copy

``` shell
cd ~/ukokkei_vagrant_ansible

cp  Vagrantfile /Users/kohei/development/github/ukokkei/Vagrantfile
cp  ansible.cfg /Users/kohei/development/github/ukokkei/ansible.cfg
cp  install-ansible.sh /Users/kohei/development/github/ukokkei/install-ansible.sh
cp  inventory /Users/kohei/development/github/ukokkei/inventory
cp -R provisioning /Users/kohei/development/github/ukokkei/provisioning
```

## step 3 vagrant up(auto provisioning)

this takes time for a while

``` shell
cd ~/development/github/ukokkei
vagrant up
```

if you want provison again

```
vagrant provision
```

## step 4 rails s

```
vagrant ssh
cd /vagrant/ukokkei_dummy
rails s -b 0.0.0.0
# then asccess localhost:3000/admin on your browser
```


# Note

## Note 1
plase comment out this line of VagrantFile once you install ansible on controller if it's annoying

```
machine.vm.provision :shell, path: "install-ansible.sh"

```

## Note 2
when rials doesn't render when u login in admin page
add this at the end of ukokkei_dummy/config/environments/development.rb

```
config.web_console.whiny_requests = false
```

## Note 3
if you failed budle install on VM, it migth be bacause too much memory using
then please allow more memory on your VM like below on VagrantFile

```
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
```

# Ref

- [ansible](http://docs.ansible.com)
- [vagrant](https://www.vagrantup.com/docs/provisioning/ansible_local.html)
- [vagrant ansibel_local(with ansible v 2) error](http://qiita.com/dz_/items/e696627e792dc54b8c21)
- [rails error](https://solidfoundationwebdev.com/blog/posts/cannot-render-console-from-some-ip-with-rails)
- [PostgresSQL 9.5.x on ubuntu](https://www.howtoforge.com/tutorial/how-to-install-postgresql-95-on-ubuntu-12_04-15_10/)