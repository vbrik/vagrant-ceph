#!/bin/bash
set -ex

ceph-deploy new ceph-{1..3}
cat <<-EOF >> ceph.conf
	mon_clock_drift_allowed = 1
	osd pool default size = 2
	public_network = 172.21.12.0/24 # adding monitors fails without this?
	mon_allow_pool_delete = true
	mon pg warn min per osd = 1
	#auth cluster required = none
	#auth service required = none
	#auth client required = none
EOF
ceph-deploy mon create-initial
ceph-deploy admin admin client ceph-{1..3}
sudo chmod +r /etc/ceph/ceph.client.admin.keyring
for s in ceph-{1..3}; do
    ssh $s sudo chmod +r /etc/ceph/ceph.client.admin.keyring
done
ceph-deploy mgr create ceph-{1..3}
for s in ceph-{1..3}; do
    ceph-deploy osd create --data pvs/a $s
done
ceph-deploy mds create ceph-{1..3}
ceph-deploy rgw create ceph-{1..3}
#ceph osd pool create rbd 8
##ceph osd pool application enable rbd rbd
#rbd pool init rbd
#	on client
#	rbd create --size 4096 foo
#	rbd feature disable object-map fast-diff deep-flatten rbd/foo
#	# only layering, exclusive-lock features enabled
#	rbd map foo --name client.admin
#	mkfs.ext4 -m0 /dev/rbd/rbd/foo
#
# ceph osd pool create cephfs_data <pg_num>
# ceph osd pool create cephfs_metadata <pg_num>
# ceph fs new cephfs cephfs_metadata cephfs_data
# ceph fs ls
ceph health
ceph -s

#ceph-deploy mon add ceph-3

# vim:noexpandtab
