# required plugins: vagrant-hostmanager and vagrant-persistent-storage

vagrant_root = File.dirname(File.expand_path(__FILE__))

Vagrant.configure("2") do |config|
  config.vm.box = "ceph-base"
  config.ssh.forward_agent = true
  config.ssh.insert_key = false
  config.ssh.compression = false
  config.hostmanager.enabled = true

  (1..3).each do |i|
    config.vm.define "ceph-#{i}" do |server|
      config.ssh.username = 'root'
      config.vm.provider "virtualbox" do |vb|
        vb.cpus = 2
      end
      server.vm.hostname = "ceph-#{i}"
      server.vm.network :private_network, ip: "172.21.12.#{i+11}"
      server.persistent_storage.enabled = true
      server.persistent_storage.size = 100 * 1000 #100 GB
      server.persistent_storage.partition = false
      server.persistent_storage.use_lvm = false
      server.persistent_storage.location = File.join(vagrant_root, ".disks/ceph-1-#{i}.vdi")
    end
  end
  
  config.vm.define "client" do |client|
    config.ssh.username = 'root'
    client.vm.hostname = "client"
    client.vm.network :private_network, ip: "172.21.12.11"
  end

  config.vm.define "admin" do |admin|
    admin.vm.hostname = "admin"
    admin.vm.network :private_network, ip: "172.21.12.10"
    admin.vm.provision :shell, :privileged => false, :inline => <<-EOF
        ssh-keyscan admin client ceph-{1..3} >> ~/.ssh/known_hosts 2> /dev/null
        echo ceph-{1..3} >> ~/pssh-ceph-nodes
        echo admin client ceph-{1..3} >> ~/pssh-all-nodes
        yum install -y pssh jq
      EOF
  end
end

# vim:ft=ruby:tabstop=2:softtabstop=2:shiftwidth=2
