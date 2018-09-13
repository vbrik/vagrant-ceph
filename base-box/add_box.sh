#!/bin/bash

set -ex
time vagrant destroy -f
time vagrant up
rm -f ceph-base.box
time vagrant package --output ceph-base.box
time vagrant box add --force ceph-base ceph-base.box
