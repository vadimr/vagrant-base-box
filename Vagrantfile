# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |v|
    v.name = "R"
    v.memory = 4096
    v.cpus = 2
    v.customize ["guestproperty", "set", :id, "--timesync-threshold", 5000]
  end

end
