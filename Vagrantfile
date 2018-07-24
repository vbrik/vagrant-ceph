# -*- mode: ruby -*-
# vim:ft=ruby:tabstop=2:softtabstop=2:shiftwidth=2

Vagrant.configure("2") do |config|
  config.vm.box = "ceph-base"
  config.ssh.forward_agent = true
  config.ssh.insert_key = false
  config.hostmanager.enabled = true

  # We provision three nodes to be Ceph servers
  (1..3).each do |i|
    config.vm.define "ceph-server-#{i}" do |config|
      config.vm.hostname = "ceph-server-#{i}"
      config.vm.network :private_network, ip: "172.21.12.#{i+11}"
    end
  end
  
  # The Ceph client will be our client machine to mount volumes and interact with the cluster
  config.vm.define "ceph-client" do |client|
    client.vm.hostname = "ceph-client"
    client.vm.network :private_network, ip: "172.21.12.11"
  end

  # We need one Ceph admin machine to manage the cluster
  config.vm.define "ceph-admin" do |admin|
    admin.vm.hostname = "ceph-admin"
    admin.vm.network :private_network, ip: "172.21.12.10"
    admin.vm.provision :shell, :inline => "ssh-keyscan ceph-client ceph-server-{1..3} >> ~/.ssh/known_hosts 2> /dev/null", :privileged => false
  end
end
