#!/bin/bash
set -e

machines=$(vagrant status | grep running | awk '{print $1}')

for m in $machines; do
    echo $m $(vagrant port --guest 22 $m)
done


