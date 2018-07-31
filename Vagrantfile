# required plugins: vagrant-hostmanager and vagrant-persistent-storage

vagrant_root = File.dirname(File.expand_path(__FILE__))

Vagrant.configure("2") do |config|
  config.vm.box = "ceph-base"
  config.ssh.forward_agent = true
  config.ssh.insert_key = false
  config.hostmanager.enabled = true

  (1..3).each do |i|
    config.vm.define "ceph-server-#{i}" do |server|
      server.vm.hostname = "ceph-server-#{i}"
      server.vm.network :private_network, ip: "172.21.12.#{i+11}"
      server.persistent_storage.enabled = true
      server.persistent_storage.size = 100 * 1000 #GB
      server.persistent_storage.partition = false
      server.persistent_storage.use_lvm = false
      server.persistent_storage.location = File.join(vagrant_root, "ceph-server-#{i}.vdi")
    end
  end
  
  config.vm.define "ceph-client" do |client|
    client.vm.hostname = "ceph-client"
    client.vm.network :private_network, ip: "172.21.12.11"
  end

  config.vm.define "ceph-admin" do |admin|
    admin.vm.hostname = "ceph-admin"
    admin.vm.network :private_network, ip: "172.21.12.10"
    admin.vm.provision :shell, :privileged => false, \
      :inline => "ssh-keyscan ceph-client ceph-server-{1..3} >> ~/.ssh/known_hosts 2> /dev/null"
  end
end

# vim:ft=ruby:tabstop=2:softtabstop=2:shiftwidth=2
