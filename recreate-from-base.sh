#!/bin/bash
set -ex
time vagrant destroy -f
cd base-box
time ./add_box.sh
cd -
time vagrant up
