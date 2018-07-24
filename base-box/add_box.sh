#!/bin/bash

set -ex
vagrant destroy -f
vagrant up
rm -f ceph-base.box
vagrant package --output ceph-base.box
vagrant box add --force ceph-base ceph-base.box
