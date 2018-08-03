# required plugins: vagrant-hostmanager and vagrant-persistent-storage

vagrant_root = File.dirname(File.expand_path(__FILE__))

Vagrant.configure("2") do |config|
  config.vm.box = "ceph-base"
  config.ssh.forward_agent = true
  config.ssh.insert_key = false
  config.ssh.compression = false
#  config.hostmanager.enabled = true

  (1..3).each do |i|
    config.vm.define "ceph-#{i}" do |server|
      server.ssh.username = 'root'
      server.vm.hostname = "ceph-#{i}"
      server.vm.network :private_network, ip: "172.21.12.#{i+11}"
      server.vm.provider "virtualbox" do |vb|
        vb.cpus = 2
      end
      server.vm.provision :shell, :inline => <<-EOF
          set -x
          pvs /dev/sdb || (pvcreate /dev/sdb && vgcreate pvs /dev/sdb)
        EOF
      server.persistent_storage.enabled = true
      server.persistent_storage.size = 100 * 1000 #100 GB
      server.persistent_storage.partition = false
      server.persistent_storage.use_lvm = false
      server.persistent_storage.location = File.join(vagrant_root, ".disks/ceph-#{i}.vdi")
    end
  end
  
  config.vm.define "client" do |client|
    client.ssh.username = 'root'
    client.vm.hostname = "client"
    client.vm.network :private_network, ip: "172.21.12.11"
  end

  config.vm.define "admin" do |admin|
    admin.vm.hostname = "admin"
    admin.vm.network :private_network, ip: "172.21.12.10"
    admin.vm.provision :shell, :inline => "yum install -y pssh jq"
    admin.vm.provision :shell, :privileged => false, :inline => <<-EOF
        set -x
        ssh-keyscan admin client ceph-{1..3} >> ~/.ssh/known_hosts 2> /dev/null
        echo ceph-{1..3} | tr ' ' '\n' > ~/nodes-ceph
        echo admin client ceph-{1..3} | tr ' ' '\n' > ~/nodes-all
      EOF
  end
end

# vim:ft=ruby:tabstop=2:softtabstop=2:shiftwidth=2
