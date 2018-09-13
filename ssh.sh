#!/bin/bash
set -ex
ssh -l root -p $(grep $1 port_22_map | awk '{print $2}') -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no 127.0.0.1
