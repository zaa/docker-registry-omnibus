# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.synced_folder "./", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.define :centos do |centos|
    centos.vm.box = "chef/centos-6.6"
    centos.vm.provision "shell", :path => "./provisioning/centos.sh", :privileged => false
  end
end
