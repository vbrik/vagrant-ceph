#!/bin/bash
set -ex

ceph-deploy new ceph-server-{1..3}
cat <<-EOF >> ceph.conf
	mon_clock_drift_allowed = 1
	osd pool default size = 2
	public_network = 172.21.12.0/24 # adding monitors fails without this?
	mon_allow_pool_delete = true
EOF
ceph-deploy mon create-initial
ceph-deploy admin ceph-admin ceph-client ceph-server-{1..3}
sudo chmod +r /etc/ceph/ceph.client.admin.keyring
for s in ceph-server-{1..3}; do
    ssh $s sudo chmod +r /etc/ceph/ceph.client.admin.keyring
done
ceph-deploy mgr create ceph-server-{1..3}
for s in ceph-server-{1..3}; do
    ceph-deploy osd create --data pvs/a ceph-server-$i
done
ceph-deploy mds create ceph-server-1
ceph-deploy rgw create ceph-server-1
ceph health
ceph -s

ceph-deploy mon add ceph-server-3

# vim:noexpandtab
