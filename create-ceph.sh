#!/bin/bash
set -ex

ceph-deploy new ceph-{1..2}
cat <<-EOF >> ceph.conf
	mon_clock_drift_allowed = 1
	osd pool default size = 2
	public_network = 172.21.12.0/24 # adding monitors fails without this?
	mon_allow_pool_delete = true
EOF
ceph-deploy mon create-initial
ceph-deploy admin admin client ceph-{1..2}
sudo chmod +r /etc/ceph/ceph.client.admin.keyring
for s in ceph-{1..2}; do
    ssh $s sudo chmod +r /etc/ceph/ceph.client.admin.keyring
done
ceph-deploy mgr create ceph-{1..2}
for s in ceph-{1..2}; do
    ceph-deploy osd create --data pvs/a $s
done
ceph-deploy mds create ceph-1
ceph-deploy rgw create ceph-1
ceph osd pool create rbd 8
ceph osd pool application enable rbd rbd
ceph health
ceph -s

#ceph-deploy mon add ceph-3

# vim:noexpandtab
