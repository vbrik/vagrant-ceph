#!/bin/bash
set -ex
ssh-add -l | grep .vagrant.d/insecure_private_key
time vagrant destroy -f
cd base-box
time ./add_box.sh
cd -
time vagrant up
