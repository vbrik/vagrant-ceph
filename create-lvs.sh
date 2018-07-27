#!/bin/bash

pvcreate /dev/sdc
vgcreate pvs /dev/sdc
lvcreate -l 25%VG -n a pvs
lvcreate -l 25%VG -n b pvs
lvcreate -l 25%VG -n c pvs
lvcreate -l 25%VG -n d pvs
