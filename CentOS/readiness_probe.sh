#!/bin/bash

# Disk full
while true
do
        # sleep early to get glusterd settled
        sleep 120
        current_usage=$( df --output=pcent  '/var/lib/glusterd' | tail -n1  | awk {'print $1'} )
        max_usage=99%
        if [ "${current_usage%?}" -ge "${max_usage%?}" ]; then
                echo "running out of space in /var/lib/glusterd - stop glusterd"
                systemctl stop glusterd.service
                break
        fi
done
