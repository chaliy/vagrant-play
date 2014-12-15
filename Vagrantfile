# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "mwrock/Windows2012R2"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true

    vb.memory = 3072
    vb.cpus = 1

    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  (1..3).each do |i|
    name = "node-#{i}"
    ip = "10.0.0.#{i+100}"
    config.vm.define name do |node|
      # node.vm.network :private_network, ip:ip
      node.vm.host_name = name
    end
  end

  config.vm.provision "shell", inline: <<-SHELL
    if (-not (get-command choco*)) {
      iwr https://chocolatey.org/install.ps1 | iex
    }
    choco install puppet
    certutil -v -addstore Root '\\\\VBOXSVR\\vagrant\\geotrustglobalca.pem'
  SHELL

  config.vm.provision "shell", inline: <<-SHELL
    puppet module install rismoney-chocolatey
  SHELL

  config.vm.provision "puppet"  do |puppet|
    puppet.manifests_path = "."
    puppet.manifest_file = "default.pp"
  end

end
