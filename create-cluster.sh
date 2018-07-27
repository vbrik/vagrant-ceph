#!/bin/bash
set -ex

ceph-deploy new ceph-server-{1..3}
echo "osd pool default size = 2" >> ceph.conf
echo "mon_clock_drift_allowed = 1" >> ceph.conf
ceph-deploy mon create-initial
ceph-deploy admin ceph-admin ceph-client ceph-server-{1..3}
sudo chmod +r /etc/ceph/ceph.client.admin.keyring
for i in {1..3}; do
    ssh ceph-server-$i sudo chmod +r /etc/ceph/ceph.client.admin.keyring
    #ssh ceph-server-$i "sudo mkdir /var/local/osd$i && sudo chown ceph:ceph /var/local/osd$i"
    #ceph-deploy osd prepare ceph-server-$i:/var/local/osd$i
    #ceph-deploy osd activate ceph-server-$i:/var/local/osd$i
done
ceph-deploy mgr create ceph-server-{1..3}
ceph health
ceph -s
