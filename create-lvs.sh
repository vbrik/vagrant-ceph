#!/bin/bash
set -xe
#pvcreate /dev/sdb
#vgcreate pvs /dev/sdb
lvcreate -L 3G -n a pvs
#lvcreate -l 33%VG -n a pvs
#lvcreate -l 33%VG -n b pvs
#lvcreate -l 33%VG -n c pvs
